
import '../sent_message_base.dart';

class SentTextMessage extends SentMessageBase {

  final String textMessage;

  const SentTextMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.senderId,
    required super.receiverId,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteSentDate,
    required super.messageDeliveryState,
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
        textMessage
      ];
}
