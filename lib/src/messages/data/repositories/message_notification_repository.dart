import '../../../core/notification/data/datasources/local/local_notifications_service.dart';
import '../../../core/notification/data/model/notification_payload.dart';
import '../../domain/entities/image_message/received_image_message.dart';
import '../../domain/entities/messages_base.dart';
import '../../domain/entities/text_message/received_text_message.dart';
import '../../domain/repositories/message_notification_repository.dart';

class MessageNotificationRepositoryImpl extends MessageNotificationRepository {
  final LocalNotificationsService _localNotificationsService;

  const MessageNotificationRepositoryImpl(this._localNotificationsService);

  @override
  Future<void> disposeNotificationGroup(String notificationGroupID) {
    return _localNotificationsService
        .disposeNotificationGroup(notificationGroupID);
  }

  @override
  Future<void> showMessageNotification(MessageBase message) {
    String bodyText = 'Unsupported message type.';

    if (message is ReceivedTextMessage) {
      bodyText = message.textMessage;
    } else if (message is ReceivedImageMessage) {
      bodyText = '📷️ Image';
    }

    return _localNotificationsService.showMessageNotification(
      NotificationPayload(
        notificationID: message.localMessageId,
        groupID: message.user.userId,
        title: message.user.name,
        bodyText: bodyText,
        messageType: message.messageType,
        largeIconURL: message.user.profileImageURL,
        largeIconFilePath: message.user.profileImageFile?.path,
      ),
    );
  }
}
