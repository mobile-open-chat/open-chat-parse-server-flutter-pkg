import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart' show protected;
import 'package:rxdart/rxdart.dart';

import '../../../core/data/process_manager_base/process_manager_base.dart';
import '../../../core/error/exceptions/user_exception.dart';
import '../../../core/user/domain/entities/user.dart';
import '../../../core/utils/either.dart';
import '../../domain/entities/connection_state.dart';
import '../../domain/entities/image_message/image.dart';
import '../../domain/entities/image_message/received_image_message.dart';
import '../../domain/entities/image_message/sent_image_message.dart';
import '../../domain/entities/messages_base.dart';
import '../../utils/chat_typedef.dart';
import '../../utils/progress.dart';
import '../datasources/local/messages_local_data_source.dart';
import '../datasources/local/models/messages_collection_model.dart'
    hide ImageMessage;
import '../datasources/remote/messages_remote_data_source.dart';
import '../models/image_message/received_image_message_model.dart';
import '../models/image_message/sent_image_message_model.dart';
import 'utils/utils_functions.dart';

typedef BehaviorSubjectOfProgressOrImageMessage
    = BehaviorSubject<Either<Progress, ImageMessage>>;

class DownloadImageMessageProcessManager extends ProcessManagerBase<
    ValueStreamOfProgressOrImageMessage, ImageMessage> {
  final MessagesLocalDataSource _messagesLocalDataSource;
  final MessagesRemoteDataSource _messagesRemoteDataSource;

  DownloadImageMessageProcessManager(
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

  final Map<int, BehaviorSubjectOfProgressOrImageMessage>
      _downloadingProcesses = {};

  final _disposableProcesses = <int>{};

  final _pendingPrecesses = ListQueue<ImageMessage>();

  @override
  ValueStreamOfProgressOrImageMessage startOrAttachToRunningProcess(
    ImageMessage message,
  ) {
    return _downloadingProcesses.putIfAbsent(
      (message as MessageBase).localMessageId,
      () {
        return _returnBehaviorSubjectThenStartDownloadingProcess(message);
      },
    ).stream;
  }

  BehaviorSubjectOfProgressOrImageMessage
      _returnBehaviorSubjectThenStartDownloadingProcess(
    ImageMessage imageMessage,
  ) {
    final downloadBehaviorSubject = BehaviorSubjectOfProgressOrImageMessage();

    _startDownloadingProcess(downloadBehaviorSubject, imageMessage);

    return downloadBehaviorSubject;
  }

  Future<void> _startDownloadingProcess(
    BehaviorSubjectOfProgressOrImageMessage downloadBehaviorSubject,
    ImageMessage imageMessage,
  ) async {
    var message = imageMessage;
    final processId = (message as MessageBase).localMessageId;
    final localModel = _getLocalDBModel(message);

    if (await _shouldDownloadThumbnail(message)) {
      final imageMessageResult = await _downloadThumbnail(message, localModel);
      if (imageMessageResult != null) {
        message = imageMessageResult;
        downloadBehaviorSubject.sink.add(
          Right(message),
        );
      }
    }

    File downloadedImageFile;
    try {
      downloadedImageFile = await _messagesRemoteDataSource.downloadFile(
        message.image.imageURL!,
        (progress, total) {
          downloadBehaviorSubject.sink.add(Left(Progress(total, progress)));
        },
      );
    } on InternetConnectionException catch (error) {
      downloadBehaviorSubject.sink.addError(error.asFailure());
      _pendingPrecesses.add(message);
      await disposeProcess(processId);
      return;
    }

    try {
      downloadedImageFile = await saveFileToAppDocumentsDirectory(
        downloadedImageFile,
        FolderName.images,
      );
    } catch (error) {
      downloadBehaviorSubject.sink.addError(
        ErrorWhileSavingTheFile(
          "can't save the downloaded image to app documents directory\nError: ${error.toString()}",
        ).asFailure(),
      );

      await disposeProcess(processId);
      return;
    }

    localModel.imageMessage!.imageFilePath = downloadedImageFile.path;
    message = await _updateMessageInLocalDB(
      localModel,
      (message as MessageBase).user,
    );

    downloadBehaviorSubject.sink.add(
      Right(message),
    );

    _disposableProcesses.add(processId);

    await downloadBehaviorSubject.close();
  }

  MessagesCollectionModel _getLocalDBModel(
    ImageMessage message,
  ) {
    if (message is ReceivedImageMessage) {
      return ReceivedImageMessageModel.fromEntity(message).toLocalDBModel();
    }

    if (message is SentImageMessage) {
      return SentImageMessageModel.fromEntity(message).toLocalDBModel();
    }

    throw 'Dead zone';
  }

  Future<ImageMessage> _updateMessageInLocalDB(
    MessagesCollectionModel localMessageModel,
    User user,
  ) async {
    await _messagesLocalDataSource.updateMessage(localMessageModel);

    if (localMessageModel.isReceivedMessage()) {
      return ReceivedImageMessageModel.fromLocalDBModel(
        localMessageModel,
        user,
      );
    } else {
      return SentImageMessageModel.fromLocalDBModel(localMessageModel, user);
    }
  }

  Future<bool> _shouldDownloadThumbnail(ImageMessage message) async {
    return (await message.image.thumbnailFile?.notExists()) ?? true;
  }

  Future<ImageMessage?> _downloadThumbnail(
    ImageMessage message,
    MessagesCollectionModel localModel,
  ) async {
    File thumbnailImageFile;
    try {
      thumbnailImageFile = await _messagesRemoteDataSource.downloadFile(
        message.image.thumbnailURL!,
        (__, _) {},
      );
      // ignore: empty_catches
    } catch (error) {
      return null;
    }

    try {
      thumbnailImageFile = await saveFileToAppDocumentsDirectory(
        thumbnailImageFile,
        FolderName.images,
      );
      // ignore: empty_catches
    } catch (error) {
      return null;
    }

    localModel.imageMessage!.thumbnailFilePath = thumbnailImageFile.path;
    return _updateMessageInLocalDB(localModel, (message as MessageBase).user);
  }

  @override
  @protected
  Future<void> disposeProcess(int processId) async {
    await _downloadingProcesses[processId]?.close();
    _downloadingProcesses.remove(processId);
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
    for (final process in _downloadingProcesses.values) {
      await process.close();
    }
    _pendingPrecesses.clear();
    _downloadingProcesses.clear();
    _disposableProcesses.clear();
  }
}

extension _NotExists on File {
  Future<bool> notExists() async {
    return !(await exists());
  }
}
