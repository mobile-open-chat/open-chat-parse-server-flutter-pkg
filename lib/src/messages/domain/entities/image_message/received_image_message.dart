import '../../../../core/utils/undefined.dart';
import '../received_message_base.dart';
import 'image.dart';

class ReceivedImageMessage extends ReceivedMessageBase {
  final Image receivedImage;

  const ReceivedImageMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.userId,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required super.isLiveMessage,
    required this.receivedImage,
  });

  ReceivedImageMessage copyWith({
    int? localMessageId,
    Object? remoteMessageId = undefined,
    String? userId,
    DateTime? localSentDate,
    DateTime? localReceivedDate,
    Object? remoteCreationDate = undefined,
    ReceivedMessageDeliveryState? messageDeliveryState,
    bool? isLiveMessage,
    Image? receivedImage,
  }) {
    return ReceivedImageMessage(
      localMessageId: localMessageId ?? this.localMessageId,
      remoteMessageId: isNotPassedParameter(remoteMessageId)
          ? this.remoteMessageId
          : (remoteMessageId as String?),
      userId: userId ?? this.userId,
      localSentDate: localSentDate ?? this.localSentDate,
      localReceivedDate: localReceivedDate ?? this.localReceivedDate,
      remoteCreationDate: isNotPassedParameter(remoteCreationDate)
          ? this.remoteCreationDate
          : (remoteCreationDate as DateTime?),
      messageDeliveryState: messageDeliveryState ?? this.messageDeliveryState,
      isLiveMessage: isLiveMessage ?? this.isLiveMessage,
      receivedImage: receivedImage ?? this.receivedImage,
    );
  }

  @override
  List<Object?> get props => [
        localMessageId,
        remoteMessageId,
        userId,
        localSentDate,
        localReceivedDate,
        remoteCreationDate,
        messageDeliveryState,
        isLiveMessage,
        receivedImage,
      ];
}
