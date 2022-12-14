import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart' show protected;

import '../../../core/data/process_manager_base/process_manager_base.dart';
import '../../../core/error/exceptions/exception_base.dart';
import '../../../core/error/exceptions/server_exception.dart';
import '../../../core/error/exceptions/user_exception.dart';
import '../../../core/utils/either.dart';
import '../../domain/entities/connection_state.dart';
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
  ) {
    late final StreamSubscription subscription;
    subscription = _messagesRemoteDataSource.connectionStateStream().listen(
      (connectionState) {
        if (connectionState == ConnectionState.connected ||
            connectionState == ConnectionState.updated) {
          _restartAllPendingProcesses();
        }
      },
      onDone: () {
        subscription.cancel();
      },
    );
  }

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
    final processId = sentTextMessage.localMessageId;
    final messageModel = SentTextMessageModel.fromEntity(sentTextMessage);
    final localModel = messageModel.toLocalDBModel();
    final remoteModel = messageModel.toRemoteModel();

    await _messagesLocalDataSource.storeMessage(localModel);

    final RemoteMessageModel remoteMessageModelResponse;
    try {
      remoteMessageModelResponse =
          await _messagesRemoteDataSource.sendTextMessage(remoteModel);
    } on InternetConnectionException catch (exception) {
      // Add the process(message) to pending precesses so when the connection
      // returns the process will restart and try to resend the message.
      _pendingPrecesses.addLast(messageModel);

      await disposeProcess(processId);
      return Left(exception);
    } on ServerException catch (exception) {
      await _markTheMessageWithErrorDeliveryStateInDB(localModel);
      await disposeProcess(processId);
      return Left(exception);
    }

    localModel
      ..remoteMessageId = remoteMessageModelResponse.remoteMessageId
      ..remoteCreationDate = remoteMessageModelResponse.remoteCreationDate
      ..sentMessageProperties!.sentMessageDeliveryState =
          SentMessageDeliveryState.sent;

    await _messagesLocalDataSource.updateMessage(localModel);

    _disposableProcesses.add(processId);

    return Right(
      SentTextMessageModel.fromLocalDBModel(
        localModel,
        messageModel.user,
      ),
    );
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
      await disposeProcess(processId);
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
