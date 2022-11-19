import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../services/permission_manager.dart';

import '../../model/notification_payload.dart';
import '../local/local_notifications_service.dart';

abstract class RemotePushNotificationsService {
  Future<void> initialize();

  Future<void> deleteDevicePushNotificationsToken();
  
  Stream<String> onDevicePushNotificationsTokenRefresh();
}

class RemotePushNotificationsServiceImpl
    extends RemotePushNotificationsService {
  @override
  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @override
  Future<void> deleteDevicePushNotificationsToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  @override
  Stream<String> onDevicePushNotificationsTokenRefresh() {
    return FirebaseMessaging.instance.onTokenRefresh;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationPayload? payload;
  try {
    payload = NotificationPayload.fromJson(message.data);
  } catch (error) {
    log('can not parse the message payload form FCM');
  }
  if (payload != null) {
    await LocalNotificationsService.impl(PermissionManager.impl())
        .showMessageNotification(payload);
  }
}
