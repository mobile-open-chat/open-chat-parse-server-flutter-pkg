import 'dart:collection';

import 'package:flutter/foundation.dart' show protected;

import '../../../core/data/process_manager_base/process_manager_base.dart';
import '../../../core/error/exceptions/cache_exception.dart';
import '../../../core/error/exceptions/exception_base.dart';
import '../../../core/error/exceptions/server_exception.dart';
import '../../../core/error/exceptions/user_exception.dart';
import '../../../core/utils/either.dart';
import '../../domain/entities/sent_message_base.dart';
import '../../domain/entities/text_message/sent_text_message.dart';
import '../datasources/local/messages_local_data_source.dart';
import '../datasources/local/models/messages_collection_model.dart';
import '../datasources/remote/messages_remote_data_source.dart';
import '../datasources/remote/models/remote_message_model.dart';
import '../models/text_message/sent_text_message_model.dart';

typedef ErrorOrMessage = Either<ExceptionBase, SentTextMessageModel>;

class SendTextMessageProcessManager
    extends ProcessManagerBase<Future<ErrorOrMessage>, SentTextMessage> {
  final MessagesLocalDataSource _messagesLocalDataSource;
  final MessagesRemoteDataSource _messagesRemoteDataSource;

  SendTextMessageProcessManager(
    this._messagesLocalDataSource,
    this._messagesRemoteDataSource,
  );

  final Map<int, Future<ErrorOrMessage>> _sendingProcesses = {};

  final _disposableProcesses = <int>{};

  final _pendingPrecesses = ListQueue<SentTextMessageModel>();

  @override
  Future<ErrorOrMessage> startOrAttachToRunningProcess(
    SentTextMessage message,
  ) {
    return _sendingProcesses.putIfAbsent(
      message.localMessageId,
      () => _startSendingProcess(message),
    );
  }

  Future<ErrorOrMessage> _startSendingProcess(
    SentTextMessage sentTextMessage,
  ) async {
    final messageModel = SentTextMessageModel.fromEntity(sentTextMessage);
    final localModel = messageModel.toLocalDBModel();
    final remoteModel = messageModel.toRemoteModel();

    final isSuccess = await _messagesLocalDataSource.storeMessage(localModel);
    if (!isSuccess) {
      _sendingProcesses.remove(messageModel.localMessageId);
      return Left(const CacheException("Can't store the new text message"));
    }

    final RemoteMessageModel remoteMessageModelResponse;
    try {
      remoteMessageModelResponse =
          await _messagesRemoteDataSource.sendTextMessage(remoteModel);
    } on InternetConnectionException catch (exception) {
      // Add the process(message) to pending precesses so when the connection
      // returns the process will restart and try to resend the message.
      _pendingPrecesses.addLast(messageModel);
      return Left(exception);
    } on ServerException catch (exception) {
      await _markTheMessageWithErrorDeliveryStateInDB(localModel);

      return Left(exception);
    } finally {
      // Remove the current process(message) in case of error,
      // so the next attempt to send the message will start a new process.
      disposeProcess(messageModel.localMessageId);
    }

    localModel
      ..remoteMessageId = remoteMessageModelResponse.remoteMessageId
      ..remoteCreationDate = remoteMessageModelResponse.remoteCreationDate
      ..sentMessageProperties!.sentMessageDeliveryState =
          SentMessageDeliveryState.sent;

    await _messagesLocalDataSource.updateMessage(localModel);

    _disposableProcesses.add(messageModel.localMessageId);

    return Right(SentTextMessageModel.fromLocalDBModel(localModel));
  }

  Future<void> _markTheMessageWithErrorDeliveryStateInDB(
    MessagesCollectionModel localModel,
  ) async {
    localModel.sentMessageProperties!.sentMessageDeliveryState =
        SentMessageDeliveryState.error;

    await _messagesLocalDataSource.updateMessage(localModel);
  }

  void _restartAllPendingProcesses() {
    for (int i = 0; i < _pendingPrecesses.length; i++) {
      startOrAttachToRunningProcess(_pendingPrecesses.removeFirst());
    }
  }

  @override
  Future<void> disposeAllFinishedProcesses() async {
    for (final processId in _disposableProcesses) {
      disposeProcess(processId);
    }
    _disposableProcesses.clear();
  }

  @override
  Future<void> disposeAllProcesses() async {
    _sendingProcesses.clear();
    _pendingPrecesses.clear();
    _disposableProcesses.clear();
  }

  @override
  @protected
  Future<void> disposeProcess(int processId) async {
    _sendingProcesses.remove(processId);
  }
}
