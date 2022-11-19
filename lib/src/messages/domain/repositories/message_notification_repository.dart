import '../entities/messages_base.dart';

abstract class MessageNotificationRepository {
  const MessageNotificationRepository();

  Future<void> showMessageNotification(MessageBase message);

  Future<void> disposeNotificationGroup(String notificationGroupID);
}
