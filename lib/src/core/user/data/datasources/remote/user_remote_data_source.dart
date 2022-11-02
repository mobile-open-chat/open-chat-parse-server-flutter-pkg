import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../../error/exceptions/server_exception.dart';
import '../../../../error/exceptions/user_exception.dart';
import '../../models/custom_parse_user.dart';

abstract class UserRemoteDataSource {
  Future<CustomParseUser> getUpdatedUserFromServer(
    CustomParseUser currentLocalUser,
  );
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  @override
  Future<CustomParseUser> getUpdatedUserFromServer(
    CustomParseUser currentLocalUser,
  ) async {
    ParseResponse updatedUserResponse;
    try {
      updatedUserResponse = await currentLocalUser.getUpdatedUser();
    } catch (error) {
      throw InternetConnectionException(
        'error while connecting to the server, can not get updated user\n Error: $error',
      );
    }

    if (updatedUserResponse.success &&
        updatedUserResponse.error == null &&
        updatedUserResponse.count != 0) {
      return updatedUserResponse.results!.first as CustomParseUser;
    } else {
      throw ParseException.extractParseException(updatedUserResponse.error);
    }
  }
}
