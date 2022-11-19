import 'dart:async';

import '../../../core/usecases/usecase.dart';

import '../repositories/message_notification_repository.dart';
import '../repositories/messages_repository.dart';

class SetCurrentOpenedChat implements UseCase<String?, Future<void>> {
  final MessagesRepository _messagesRepository;
  final MessageNotificationRepository _messageNotificationRepository;

  const SetCurrentOpenedChat(
    this._messagesRepository,
    this._messageNotificationRepository,
  );

  @override
  Future<void> call(String? userID) async {
    _messagesRepository.setCurrentOpenedChatID(userID);
    
    if (userID == null) {
      return;
    }
    await _messageNotificationRepository.disposeNotificationGroup(userID);
  }
}
