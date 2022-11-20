// ignore_for_file: avoid_redundant_argument_values, constant_identifier_names, avoid_classes_with_only_static_members

import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart' show NavigatorState, Colors;

import '../../../../services/permission_manager.dart';
import '../../model/notification_payload.dart';

abstract class LocalNotificationsService {
  static const CHANNEL_KEY = 'Chat';

  LocalNotificationsService();

  factory LocalNotificationsService.impl(PermissionManager permissionManager) =>
      LocalNotificationsServiceImpl(permissionManager);

  Future<void> initialize();

  Future<bool> isNotificationsAllowed();

  Future<void> showMessageNotification(NotificationPayload payload);

  Future<void> disposeAllNotifications();

  Future<void> disposeNotification(int notificationID);

  Future<void> disposeNotificationGroup(String notificationGroupID);

  Future<bool> setUpNotificationsListeners(NavigatorState navigatorState);
}

class LocalNotificationsServiceImpl extends LocalNotificationsService {
  final PermissionManager _permissionManager;

  LocalNotificationsServiceImpl(this._permissionManager);
  @override
  Future<void> disposeAllNotifications() {
    return AwesomeNotifications().cancelAll();
  }

  @override
  Future<void> disposeNotification(int notificationID) {
    return AwesomeNotifications().cancel(notificationID);
  }

  @override
  Future<void> disposeNotificationGroup(String notificationGroupID) {
    return AwesomeNotifications()
        .cancelNotificationsByGroupKey(notificationGroupID);
  }

  @override
  Future<bool> isNotificationsAllowed() {
    return _permissionManager.isNotificationsAllowed();
  }

  @override
  Future<bool> initialize() {
    _permissionManager.requestPermissionToSendNotifications();

    return AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: LocalNotificationsService.CHANNEL_KEY,
          channelName: 'Chat notifications',
          channelDescription: 'Notifications channel for chat',
          defaultColor: Colors.white,
          ledColor: Colors.white,
          enableLights: true,
          importance: NotificationImportance.Max,
          locked: false,
          defaultPrivacy: NotificationPrivacy.Public,
          playSound: true,
          channelShowBadge: true,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          enableVibration: true,
        )
      ],
      // TODO: remove the debug : true
      debug: true,
    );
  }

  @override
  Future<void> showMessageNotification(NotificationPayload payload) async {
    if (!await isNotificationsAllowed()) {
      return;
    }

    String largeIcon = 'asset://assets/images/default_avatar.png';
    if (payload.largeIconFilePath != null) {
      largeIcon = 'file://${payload.largeIconFilePath!}';
    } else if (payload.largeIconURL != null) {
      largeIcon = payload.largeIconURL!;
    }

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        channelKey: LocalNotificationsService.CHANNEL_KEY,
        id: payload.notificationID,
        summary: 'Chat',
        largeIcon: largeIcon,
        roundedLargeIcon: true,
        title: payload.title,
        body: payload.bodyText,
        wakeUpScreen: true,
        payload: payload.toJson(),
        groupKey: payload.groupID,
        category: NotificationCategory.Message,
        displayOnBackground: true,
        notificationLayout: NotificationLayout.Messaging,
        displayOnForeground: true,
        showWhen: true,
        actionType: ActionType.Default,
      ),
    );
  }

  @override
  Future<bool> setUpNotificationsListeners(NavigatorState navigatorState) {
    _NotificationController.navigatorState = navigatorState;

    return AwesomeNotifications().setListeners(
      onActionReceivedMethod: _NotificationController.onActionReceivedMethod,
    );
  }
}

class _NotificationController {
  static NavigatorState? navigatorState;

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    if (navigatorState == null) {
      final error = ArgumentError.notNull('navigatorState');
      log('Did you forgat to setup NotificationsListeners?', error: error);
      throw error;
    }
  }
}
