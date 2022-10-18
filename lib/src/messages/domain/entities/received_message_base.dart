import 'messages_base.dart';

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
  final DateTime localReceivedDate;

  const ReceivedMessageBase({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.senderId,
    required super.receiverId,
    required super.localSentDate,
    required super.remoteSentDate,
    required this.localReceivedDate,
    required this.messageDeliveryState,
    required this.isLiveMessage,
  });
}
