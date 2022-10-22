import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../models/custom_parse_user.dart';

abstract class UserLocalDataSource {
  Future<String?> getCurrentUserId();
}

class UserLocalDataSourceImpl extends UserLocalDataSource {
  @override
  Future<String?> getCurrentUserId() async {
    return ((await ParseUser.currentUser()) as CustomParseUser?)?.userId;
  }
}
