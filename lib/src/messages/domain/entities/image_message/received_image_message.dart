import '../../../../core/utils/undefined.dart';
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
    required super.isLiveMessage,
    required this.receivedImage,
  });

  ReceivedImageMessage copyWith({
    String? localMessageId,
    Object? remoteMessageId = undefined,
    String? senderId,
    String? receiverId,
    DateTime? localSentDate,
    DateTime? localReceivedDate,
    Object? remoteSentDate = undefined,
    ReceivedMessageDeliveryState? messageDeliveryState,
    bool? isLiveMessage,
    Image? receivedImage,
  }) {
    return ReceivedImageMessage(
      localMessageId: localMessageId ?? this.localMessageId,
      remoteMessageId: isNotPassedParameter(remoteMessageId)
          ? this.remoteMessageId
          : (remoteMessageId as String?),
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      localSentDate: localSentDate ?? this.localSentDate,
      localReceivedDate: localReceivedDate ?? this.localReceivedDate,
      remoteSentDate: isNotPassedParameter(remoteSentDate)
          ? this.remoteSentDate
          : (remoteSentDate as DateTime?),
      messageDeliveryState: messageDeliveryState ?? this.messageDeliveryState,
      isLiveMessage: isLiveMessage ?? this.isLiveMessage,
      receivedImage: receivedImage ?? this.receivedImage,
    );
  }

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
        receivedImage,
      ];
}
