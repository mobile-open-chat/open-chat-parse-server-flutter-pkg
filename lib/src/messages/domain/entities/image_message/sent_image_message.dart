import '../sent_message_base.dart';
import 'image.dart';

class SentImageMessage extends SentMessageBase {
  final Image sentImage;
  
  const SentImageMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.senderId,
    required super.receiverId,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteSentDate,
    required super.messageDeliveryState,
    required this.sentImage,
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
        sentImage,
      ];
}
