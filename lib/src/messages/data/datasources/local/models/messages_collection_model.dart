import 'package:collection/collection.dart';
import 'package:isar/isar.dart';

import '../../../../domain/entities/sent_message_base.dart';
import '../../../utils/enums.dart';
import '../../../utils/jenkins_map_props_to_hash_code.dart';

part 'messages_collection_model.g.dart';

@Collection(accessor: 'Messages')
@Name('Messages')
class MessagesCollectionModel {
  @Name('id')
  late Id localMessageId;

  @Name('remoteMessageId')
  @Index(unique: true)
  String? remoteMessageId;

  @Name('userId')
  @Index(
    type: IndexType.hash,
    composite: [
      CompositeIndex(
        'receivedMessageDeliveryStateForLocalDB',
        type: IndexType.value,
      )
    ],
  )
  late String userId;

  late DateTime localSentDate;

  @Name('remoteCreationDate')
  DateTime? remoteCreationDate;

  @Name('messageType')
  late String messageType;

  // For sent message
  @Name('sentMessageProperties')
  SentMessageProperties? sentMessageProperties;

  // For received message
  @Name('receivedMessageProperties')
  ReceivedMessageProperties? receivedMessageProperties;

  @Enumerated(EnumType.ordinal)
  late ReceivedMessageDeliveryStateForLocalDB
      receivedMessageDeliveryStateForLocalDB;

  // For text message
  @Name('textMessage')
  TextMessage? textMessage;

  // For image message
  @Name('imageMessage')
  ImageMessage? imageMessage;

  @Ignore()
  late final List<Object?> _props = [
    localMessageId,
    remoteMessageId,
    userId,
    localSentDate,
    remoteCreationDate,
    messageType,
    sentMessageProperties,
    receivedMessageProperties,
    receivedMessageDeliveryStateForLocalDB,
    textMessage,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessagesCollectionModel &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  int get hashCode => runtimeType.hashCode ^ jenkinsMapPropsToHashCode(_props);

  bool isReceivedMessage() {
    return receivedMessageProperties != null;
  }
}

@embedded
class TextMessage {
  @Name('text')
  late String text;

  @Ignore()
  late final List<Object?> _props = [text];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextMessage &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  int get hashCode => runtimeType.hashCode ^ jenkinsMapPropsToHashCode(_props);
}

@embedded
class ImageMessage {
  @Name('imageFilePath')
  String? imageFilePath;
  @Name('imageURL')
  String? imageURL;

  @Name('thumbnailFilePath')
  String? thumbnailFilePath;
  @Name('thumbnailURL')
  String? thumbnailURL;

  @Name('hight')
  int? hight;
  @Name('width')
  int? width;

  @Name('size')
  int? size;

  @Ignore()
  late final List<Object?> _props = [
    thumbnailURL,
    thumbnailFilePath,
    imageURL,
    imageFilePath,
    hight,
    width,
    size,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextMessage &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  int get hashCode => runtimeType.hashCode ^ jenkinsMapPropsToHashCode(_props);
}

@embedded
class SentMessageProperties {
  @Enumerated(EnumType.name)
  @Name('sentMessageDeliveryState')
  late SentMessageDeliveryState sentMessageDeliveryState;

  @Ignore()
  late final List<Object?> _props = [sentMessageDeliveryState];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SentMessageProperties &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  int get hashCode => runtimeType.hashCode ^ jenkinsMapPropsToHashCode(_props);
}

@embedded
class ReceivedMessageProperties {
  @Name('localReceivedDate')
  late DateTime localReceivedDate;

  @Ignore()
  late final List<Object?> _props = [localReceivedDate];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceivedMessageProperties &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_props, other._props);

  @override
  int get hashCode => runtimeType.hashCode ^ jenkinsMapPropsToHashCode(_props);
}
