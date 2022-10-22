import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../../core/error/exceptions/server_exception.dart';
import '../../../../core/error/exceptions/user_exception.dart';
import 'models/remote_message_model.dart';

abstract class MessagesRemoteDataSource {
  const MessagesRemoteDataSource();
  Future<RemoteMessageModel> sendTextMessage(RemoteMessageModel message);
}

class MessagesRemoteDataSourceImpl extends MessagesRemoteDataSource {
  @override
  Future<RemoteMessageModel> sendTextMessage(RemoteMessageModel message) async {
    assert(message.textMessage != null);

    final ParseResponse sendTextResponse;

    try {
      sendTextResponse = await message.create();
    } catch (error) {
      throw const InternetConnectionException(
          'Can not sent text message, connection exception');
    }
    if (sendTextResponse.success &&
        sendTextResponse.results != null &&
        sendTextResponse.count != 0) {
      return sendTextResponse.results!.first;
    } else {
      throw ParseException.extractParseException(sendTextResponse.error);
    }
  }
}
