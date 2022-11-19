import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class NotificationsRemoteDataSource {
  Future<void> saveDevicePushNotificationsToken(String deviceToken);
}

class NotificationsRemoteDataSourceImpl extends NotificationsRemoteDataSource {
  @override
  Future<void> saveDevicePushNotificationsToken(String deviceToken) async {
    final parseInstallation = await ParseInstallation.currentInstallation();
    parseInstallation.deviceToken = deviceToken;
    _saveParseInstallation(parseInstallation);
  }

  Future<void> _saveParseInstallation(
    ParseInstallation parseInstallation,
  ) async {
    int retryCount = 0;
    var retryInterval = const Duration(seconds: 2);

    ParseResponse parseInstallationResponse;
    do {
      try {
        parseInstallationResponse = await parseInstallation.create();
        if (parseInstallationResponse.success) {
          return;
        }

        await Future.delayed(retryInterval *= 2);
      } catch (error) {
        await Future.delayed(retryInterval *= 2);

        log(
          'can not send installation config to the server retrying in ${retryInterval.inSeconds} seconds... \n Error: $error',
        );
      }
    } while ((++retryCount) <= 2);
  }
}
