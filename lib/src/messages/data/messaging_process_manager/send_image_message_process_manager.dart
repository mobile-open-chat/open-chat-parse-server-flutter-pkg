import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart' show protected;

import 'package:rxdart/subjects.dart';

import '../../../core/data/process_manager_base/process_manager_base.dart';
import '../../../core/error/exceptions/server_exception.dart';
import '../../../core/error/exceptions/user_exception.dart';
import '../../../core/utils/either.dart';
import '../../domain/entities/image_message/sent_image_message.dart';
import '../../domain/entities/sent_message_base.dart';
import '../../utils/chat_typedef.dart';
import '../../utils/progress.dart';
import '../datasources/local/messages_local_data_source.dart';
import '../datasources/local/models/messages_collection_model.dart';
import '../datasources/remote/messages_remote_data_source.dart';
import '../datasources/remote/models/remote_message_model.dart';
import '../models/image_message/sent_image_message_model.dart';
import 'utils/utils_functions.dart';

typedef BehaviorSubjectOfProgressOrSentImageMessage
    = BehaviorSubject<Either<Progress, SentImageMessageModel>>;

class SendImageMessageProcessManager extends ProcessManagerBase<
    ValueStreamOfProgressOrImageMessage, SentImageMessage> {
  final MessagesLocalDataSource _messagesLocalDataSource;
  final MessagesRemoteDataSource _messagesRemoteDataSource;

  SendImageMessageProcessManager(
    this._messagesLocalDataSource,
    this._messagesRemoteDataSource,
  );

  final Map<int, BehaviorSubjectOfProgressOrSentImageMessage>
      _sendingProcesses = {};

  final _disposableProcesses = <int>{};

  final _pendingPrecesses = ListQueue<SentImageMessageModel>();

  @override
  ValueStreamOfProgressOrImageMessage startOrAttachToRunningProcess(
    SentImageMessage message,
  ) {
    return _sendingProcesses
        .putIfAbsent(
          message.localMessageId,
          () => _returnBehaviorSubjectThenStartSendingProcess(message),
        )
        .stream;
  }

  BehaviorSubjectOfProgressOrSentImageMessage
      _returnBehaviorSubjectThenStartSendingProcess(SentImageMessage message) {
    final sendingBehaviorSubject =
        BehaviorSubjectOfProgressOrSentImageMessage();

    _startSendingProcess(sendingBehaviorSubject, message);

    return sendingBehaviorSubject;
  }

  Future<void> _startSendingProcess(
    BehaviorSubjectOfProgressOrSentImageMessage sendingBehaviorSubject,
    SentImageMessage sentImageMessage,
  ) async {
    final processId = sentImageMessage.localMessageId;
    var messageModel = SentImageMessageModel.fromEntity(sentImageMessage);
    final localModel = messageModel.toLocalDBModel();
    final remoteModel = messageModel.toRemoteModel();

    await _messagesLocalDataSource.storeMessage(localModel);

    final canSkipCoping = await canSkipCopingFileToAppDocumentsDirectory(
      messageModel.sentImage.imageFile!.path,
    );
    if (!canSkipCoping) {
      final File savedImageFile;
      try {
        savedImageFile = await saveFileToAppDocumentsDirectory(
          messageModel.sentImage.imageFile!,
          FolderName.images,
        );
      } catch (error) {
        sendingBehaviorSubject.sink.addError(
          ErrorWhileSavingTheFile(
            "can't save the sended image to app documents directory\nError: $error",
          ).asFailure(),
        );
        await _markTheMessageWithErrorDeliveryStateInDB(localModel);
        await disposeProcess(processId);

        return;
      }

      // save the new image path to DB
      localModel.imageMessage!.imageFilePath = savedImageFile.path;
      await _messagesLocalDataSource.updateMessage(localModel);
      messageModel = SentImageMessageModel.fromLocalDBModel(localModel);
    }

    // start uploading process
    if (!canSkipFileUploading(remoteModel)) {
      try {
        await _messagesRemoteDataSource.uploadImageMessage(remoteModel,
            (progress, total) {
          sendingBehaviorSubject.sink.add(Left(Progress(total, progress)));
        });
      } on InternetConnectionException catch (error) {
        sendingBehaviorSubject.sink.addError(
          error.asFailure(),
        );
        // Add the process(message) to pending precesses so when the connection
        // returns the process will restart and try to resend the message.
        _pendingPrecesses.addLast(messageModel);

        await disposeProcess(processId);
      } on ServerException catch (error) {
        sendingBehaviorSubject.sink.addError(
          error.asFailure(),
        );
        await _markTheMessageWithErrorDeliveryStateInDB(localModel);
        await disposeProcess(processId);
      }

      // store the image URL
      localModel.imageMessage!.imageURL = remoteModel.remoteFile!.url;
      await _messagesLocalDataSource.updateMessage(localModel);
      messageModel = SentImageMessageModel.fromLocalDBModel(localModel);
    }

    // start sending process
    final RemoteMessageModel remoteMessageModelResponse;
    try {
      remoteMessageModelResponse =
          await _messagesRemoteDataSource.sendImageMessage(remoteModel);
    } on InternetConnectionException catch (error) {
      sendingBehaviorSubject.sink.addError(
        error.asFailure(),
      );
      // Add the process(message) to pending precesses so when the connection
      // returns the process will restart and try to resend the message.
      _pendingPrecesses.addLast(messageModel);

      await disposeProcess(processId);
      return;
    } on ServerException catch (error) {
      sendingBehaviorSubject.sink.addError(
        error.asFailure(),
      );
      await _markTheMessageWithErrorDeliveryStateInDB(localModel);
      await disposeProcess(processId);
      return;
    }

    localModel
      ..remoteMessageId = remoteMessageModelResponse.remoteMessageId
      ..remoteCreationDate = remoteMessageModelResponse.remoteCreationDate
      ..imageMessage!.thumbnailURL = remoteMessageModelResponse.thumbnail?.url
      ..imageMessage!.imageURL = remoteMessageModelResponse.remoteFile?.url
      ..sentMessageProperties!.sentMessageDeliveryState =
          SentMessageDeliveryState.sent;

    await _messagesLocalDataSource.updateMessage(localModel);

    _disposableProcesses.add(processId);

    sendingBehaviorSubject.sink.add(
      Right(SentImageMessageModel.fromLocalDBModel(localModel)),
    );

    await sendingBehaviorSubject.close();

    _messagesLocalDataSource.locallyGenerateImageThumbnailAndStoreIt(
      messageModel.localMessageId,
      await appDocumentsDirectory,
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
    for (final process in _sendingProcesses.values) {
      await process.close();
    }
    _pendingPrecesses.clear();
    _sendingProcesses.clear();
    _disposableProcesses.clear();
  }

  @override
  @protected
  Future<void> disposeProcess(int processId) async {
    await _sendingProcesses[processId]?.close();
    _sendingProcesses.remove(processId);
  }
}
