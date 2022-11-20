import 'package:flutter/widgets.dart' show NavigatorState;

import '../datasources/local/local_notifications_service.dart';
import '../datasources/remote/notifications_remote_data_source.dart';
import '../datasources/remote/remote_push_notifications_service.dart';
import '../model/notification_payload.dart';

class NotificationsRepository {
  final NotificationsRemoteDataSource _notificationsRemoteDataSource;
  final LocalNotificationsService _localNotificationsService;
  final RemotePushNotificationsService _remotePushNotificationsService;

  const NotificationsRepository(
    this._notificationsRemoteDataSource,
    this._localNotificationsService,
    this._remotePushNotificationsService,
  );

  Future<void> initialize() async {
    await _localNotificationsService.initialize();
    await _remotePushNotificationsService.initialize();

    _remotePushNotificationsService
        .onDevicePushNotificationsTokenRefresh()
        .listen((deviceToken) {
      _notificationsRemoteDataSource
          .saveDevicePushNotificationsToken(deviceToken);
    });
  }

  Future<void> disposeForLogout() async {
    await _remotePushNotificationsService.deleteDevicePushNotificationsToken();
    await _localNotificationsService.disposeAllNotifications();
  }

  Future<bool> isNotificationsAllowed() {
    return _localNotificationsService.isNotificationsAllowed();
  }

  Future<void> showMessageNotification(NotificationPayload payload) {
    return _localNotificationsService.showMessageNotification(payload);
  }

  Future<void> disposeAllNotifications() {
    return _localNotificationsService.disposeAllNotifications();
  }

  Future<void> disposeNotification(int notificationID) {
    return _localNotificationsService.disposeNotification(notificationID);
  }

  Future<void> disposeNotificationGroup(String notificationGroupID) {
    return _localNotificationsService
        .disposeNotificationGroup(notificationGroupID);
  }

  Future<bool> setUpNotificationsListeners(NavigatorState navigatorState) {
    return _localNotificationsService
        .setUpNotificationsListeners(navigatorState);
  }
}
