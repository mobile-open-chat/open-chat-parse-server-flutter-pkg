import '../datasources/local/local_notifications_service.dart';
import '../datasources/remote/notifications_remote_data_source.dart';
import '../datasources/remote/remote_push_notifications_service.dart';

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
}
