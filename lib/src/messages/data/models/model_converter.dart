import 'package:flutter/foundation.dart';

import '../../../core/user/data/models/custom_parse_user.dart';
import '../../domain/entities/image_message/image.dart';
import '../../domain/entities/messages_base.dart';
import '../../domain/entities/received_message_base.dart';
import '../../domain/entities/sent_message_base.dart';
import '../datasources/local/models/messages_collection_model.dart';
import '../datasources/remote/models/remote_message_model.dart';
import '../utils/enums.dart';

extension _BuildLocalMessageFoundation on MessagesCollectionModel {
  MessagesCollectionModel buildLocalMessageFoundation(MessageBase messageBase) {
    return this
      ..localMessageId = messageBase.localMessageId
      ..remoteMessageId = messageBase.remoteMessageId
      ..userId = messageBase.userId
      ..localSentDate = messageBase.localSentDate
      ..remoteCreationDate = messageBase.remoteCreationDate;
  }
}

mixin ReceivedMessageModelConverterMixin on ReceivedMessageBase {
  @mustCallSuper
  MessagesCollectionModel toLocalDBModel() {
    return MessagesCollectionModel().buildLocalMessageFoundation(this)
      ..receivedMessageDeliveryStateForLocalDB =
          messageDeliveryState.toDataBaseModelDeliveryStateEnum()
      ..receivedMessageProperties =
          (ReceivedMessageProperties()..localReceivedDate = localReceivedDate);
  }
}

mixin SentMessageModelConverterMixin on SentMessageBase {
  @mustCallSuper
  MessagesCollectionModel toLocalDBModel() {
    return MessagesCollectionModel().buildLocalMessageFoundation(this)
      ..receivedMessageDeliveryStateForLocalDB =
          ReceivedMessageDeliveryStateForLocalDB.nil
      ..sentMessageProperties = (SentMessageProperties()
        ..sentMessageDeliveryState = messageDeliveryState);
  }

  @mustCallSuper
  RemoteMessageModel toRemoteModel() {
    return RemoteMessageModel()
      ..sentDate = localSentDate
      ..receiver = CustomParseUser.buildUserPointer(userId)
      ..messageDeliveryState = SentMessageDeliveryState.sent.name;
  }
}

extension ImageMetaDataParser on ImageMetaData {
  Map<String, dynamic> toJson() {
    return {
      'hight': hight,
      'width': width,
      'size': size,
    };
  }

  ImageMetaData fromJson(Map<String, dynamic> jsonMap) {
    return ImageMetaData(
      hight: jsonMap['hight'] as int?,
      width: jsonMap['width'] as int?,
      size: jsonMap['size'] as int?,
    );
  }
}
