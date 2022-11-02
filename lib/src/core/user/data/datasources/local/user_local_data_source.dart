import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../../error/exceptions/user_exception.dart';
import '../../models/custom_parse_user.dart';

abstract class UserLocalDataSource {
  Future<CustomParseUser> getCurrentUser();
}

class UserLocalDataSourceImpl extends UserLocalDataSource {
  @override
  Future<CustomParseUser> getCurrentUser() async {
    final currentUser = await ParseUser.currentUser() as CustomParseUser?;

    return currentUser ?? (throw const NoUserLoggedException('No user found'));
  }
}
