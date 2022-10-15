import 'package:flutter_parse_chat/src/messages/domain/entities/messages_base.dart';

enum ReceivedMessageDeliveryState {
  /// The init value ware the message was sent to the server
  sent,

  /// The current user received the message
  delivered,

  /// The current user opened the message
  seen,
}

abstract class ReceivedMessageBase extends MessageBase {
  final ReceivedMessageDeliveryState messageDeliveryState;
  final bool isLiveMessage;

  const ReceivedMessageBase({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.senderId,
    required super.receiverId,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteSentDate,
    required this.messageDeliveryState,
    required this.isLiveMessage,
  });
}
