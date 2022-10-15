import '../received_message_base.dart';

class ReceivedTextMessage extends ReceivedMessageBase {
  final String textMessage;

  const ReceivedTextMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.senderId,
    required super.receiverId,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteSentDate,
    required super.messageDeliveryState,
    required super.isLiveMessage,
    required this.textMessage,
  });

  @override
  List<Object?> get props => [
        localMessageId,
        remoteMessageId,
        senderId,
        receiverId,
        localSentDate,
        localReceivedDate,
        remoteSentDate,
        messageDeliveryState,
        isLiveMessage,
        textMessage
      ];
}
