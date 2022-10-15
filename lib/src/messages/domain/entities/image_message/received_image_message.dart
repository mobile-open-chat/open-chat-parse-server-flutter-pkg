import '../received_message_base.dart';
import 'image.dart';

class ReceivedImageMessage extends ReceivedMessageBase {
  final Image receivedImage;

  const ReceivedImageMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.senderId,
    required super.receiverId,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteSentDate,
    required super.messageDeliveryState,
    required this.receivedImage,
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
        receivedImage,
      ];
}
