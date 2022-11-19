import 'dart:async';
import 'dart:developer';

import 'package:stream_transform/stream_transform.dart';

import '../../../core/data/process_manager_base/process_manager_base.dart';
import '../../../core/user/data/datasources/local/user_local_data_source.dart';
import '../../../core/utils/either.dart';
import '../../domain/entities/image_message/image.dart';
import '../../domain/entities/image_message/sent_image_message.dart';
import '../../domain/entities/messages_base.dart';
import '../../domain/entities/text_message/sent_text_message.dart';
import '../../domain/repositories/messages_repository.dart';
import '../../utils/chat_typedef.dart';
import '../datasources/local/messages_local_data_source.dart';
import '../datasources/remote/messages_remote_data_source.dart';
import '../datasources/remote/models/remote_message_model.dart';
import '../messaging_process_manager/send_text_message_process_manager.dart'
    show ErrorOrMessage;
import '../models/image_message/received_image_message_model.dart';
import '../models/image_message/sent_image_message_model.dart';
import '../models/message_model.dart';
import '../models/text_message/received_text_message_model.dart';
import '../models/text_message/sent_text_message_model.dart';

class MessageRepositoryImpl extends MessagesRepository {
  final MessagesLocalDataSource _messagesLocalDataSource;
  final MessagesRemoteDataSource _messagesRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  final ProcessManagerBase<Future<ErrorOrMessage>, SentTextMessage>
      _sendTextMessageProcessManager;

  final ProcessManagerBase<ValueStreamOfProgressOrSentImageMessage,
      SentImageMessage> _sendImageMessageProcessManager;

  final ProcessManagerBase<ValueStreamOfProgressOrImageMessage, ImageMessage>
      _downloadImageMessageProcessManager;

  MessageRepositoryImpl(
    this._messagesLocalDataSource,
    this._messagesRemoteDataSource,
    this._sendTextMessageProcessManager,
    this._sendImageMessageProcessManager,
    this._downloadImageMessageProcessManager,
    this._userLocalDataSource,
  );

  @override
  Future<FailureOrSentTextMessage> sendTextMessage(
    SentTextMessage textMessage,
  ) async {
    final result = await _sendTextMessageProcessManager
        .startOrAttachToRunningProcess(textMessage);

    return result.fold(
      (error) => Left(error.asFailure()),
      (message) => Right(message),
    );
  }

  @override
  ValueStreamOfProgressOrSentImageMessage sendImageMessage(
    SentImageMessage imageMessage,
  ) {
    return _sendImageMessageProcessManager
        .startOrAttachToRunningProcess(imageMessage);
  }

  @override
  ValueStreamOfProgressOrImageMessage downloadImageMessage(
    ImageMessage imageMessage,
  ) {
    return _downloadImageMessageProcessManager
        .startOrAttachToRunningProcess(imageMessage);
  }

  @override
  Stream<MessageBase> listenForMessages() async* {
    StreamController<MessageBase>? messagesStreamController =
        StreamController();

    final currentUserId = (await _userLocalDataSource.getCurrentUser()).userId;

    final lastReceivedMessageDate =
        await _messagesLocalDataSource.getLastReceivedMessageDate();

    final missedMessages = _messagesRemoteDataSource
        .pullMissedMessages(lastReceivedMessageDate)
        .asStream()
        .expand((e) => [...e])
        .map(
          (event) => _messageModelFactory(
            currentUserId: currentUserId,
            isLiveMessage: false,
            remoteModel: event,
          ),
        );

    final liveMessages = _messagesRemoteDataSource.listenForNewMessages().map(
          (event) => _messageModelFactory(
            currentUserId: currentUserId,
            isLiveMessage: true,
            remoteModel: event,
          ),
        );

    StreamSubscription? subscription;

    Future<void> dispose() async {
      await subscription?.cancel();
      subscription = null;
      messagesStreamController?.close();
      messagesStreamController = null;
    }

    Future<void> listen(MessageModel messageModel) async {
      final isSuccessful = await _messagesLocalDataSource
          .storeMessage(messageModel.toLocalDBModel());

      if (isSuccessful) {
        messagesStreamController!.sink.add(messageModel as MessageBase);
      }
    }

    subscription = (missedMessages.followedBy(liveMessages)).distinct().listen(
      listen,
      cancelOnError: false,
      onDone: dispose,
      onError: (error, stacktrace) {
        log(
          'error in messages stream:',
          error: error,
          stackTrace: stacktrace as StackTrace?,
        );
      },
    );

    messagesStreamController?.onCancel = dispose;

    yield* messagesStreamController!.stream;
  }

  MessageModel _messageModelFactory({
    required RemoteMessageModel remoteModel,
    required bool isLiveMessage,
    required String currentUserId,
  }) {
    final isReceivedMessage = remoteModel.isReceivedMessage(currentUserId);
    final isTextMessage = remoteModel.isTextMessage();
    final isImageMessage = remoteModel.isImageMessage();

    if (isTextMessage) {
      if (isReceivedMessage) {
        return ReceivedTextMessageModel.fromRemoteModel(
          remoteModel: remoteModel,
          isLiveMessage: isLiveMessage,
        );
      } else {
        return SentTextMessageModel.fromRemoteModel(remoteModel);
      }
    }

    if (isImageMessage) {
      if (isReceivedMessage) {
        return ReceivedImageMessageModel.fromRemoteModel(
          remoteModel,
          isLiveMessage: isLiveMessage,
        );
      } else {
        return SentImageMessageModel.fromRemoteModel(remoteModel);
      }
    }
    // TODO :: add not supported message
    throw UnimplementedError();
  }

  String? _currentOpenedChatID;
  @override
  String? getCurrentOpenedChatID() {
    return _currentOpenedChatID;
  }

  @override
  void setCurrentOpenedChatID(String? chatID) {
    _currentOpenedChatID = chatID;
  }
}
