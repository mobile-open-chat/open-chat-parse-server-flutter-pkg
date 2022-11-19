import 'package:awesome_notifications/awesome_notifications.dart';

abstract class PermissionManager {
  PermissionManager();

  factory PermissionManager.impl() => PermissionManagerImpl();
  
  Future<bool> isNotificationsAllowed();
  Future<bool> requestPermissionToSendNotifications();
}

class PermissionManagerImpl extends PermissionManager {
  @override
  Future<bool> isNotificationsAllowed() {
    return AwesomeNotifications().isNotificationAllowed();
  }

  @override
  Future<bool> requestPermissionToSendNotifications() {
    return AwesomeNotifications().requestPermissionToSendNotifications(
      permissions: [
        NotificationPermission.Alert,
        NotificationPermission.Sound,
        NotificationPermission.Badge,
        NotificationPermission.Vibration,
        NotificationPermission.Light,
        NotificationPermission.Car
      ],
    );
  }
}
