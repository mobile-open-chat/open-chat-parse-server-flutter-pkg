import 'dart:async';

import 'package:async/async.dart';

import '../../../core/usecases/usecase.dart';
import '../entities/messages_base.dart';
import '../entities/received_message_base.dart';
import '../repositories/message_notification_repository.dart';
import '../repositories/messages_repository.dart';

class ListenForMessages implements UseCase<NoParams, Stream<MessageBase>> {
  final MessagesRepository _messagesRepository;
  final MessageNotificationRepository _messageNotificationRepository;

  const ListenForMessages(
    this._messagesRepository,
    this._messageNotificationRepository,
  );

  @override
  Stream<MessageBase> call(_) {
    final messagesStreamSplitter =
        StreamSplitter(_messagesRepository.listenForMessages());

    late final StreamSubscription splitSubscription;
    splitSubscription = messagesStreamSplitter.split().listen(
      (message) {
        if (message is ReceivedMessageBase && message.isLiveMessage) {
          _showNotificationIfMessageNotFromOpenedChat(message);
        }
      },
      onDone: () async {
        await splitSubscription.cancel();
        messagesStreamSplitter.close();
      },
    );

    return messagesStreamSplitter.split();
  }

  Future<void> _showNotificationIfMessageNotFromOpenedChat(
    ReceivedMessageBase message,
  ) async {
    final currentOpenedChatID = _messagesRepository.getCurrentOpenedChatID();
    final messageChatID = message.user.userId;

    if (currentOpenedChatID == messageChatID) {
      return;
    }

    await _messageNotificationRepository.showMessageNotification(message);
  }
}
