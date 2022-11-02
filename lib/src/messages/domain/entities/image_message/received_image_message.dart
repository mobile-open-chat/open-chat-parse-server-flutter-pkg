import '../../../../core/user/domain/entities/user.dart';
import '../../../../core/utils/undefined.dart';
import '../received_message_base.dart';
import 'image.dart';

class ReceivedImageMessage extends ReceivedMessageBase implements ImageMessage {
  final Image receivedImage;

  const ReceivedImageMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.user,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required super.isLiveMessage,
    required this.receivedImage,
  });
  
  @override
  Image get image => receivedImage;

  ReceivedImageMessage copyWith({
    int? localMessageId,
    Object? remoteMessageId = undefined,
    User? user,
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
      user: user ?? this.user,
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
        user,
        localSentDate,
        localReceivedDate,
        remoteCreationDate,
        messageDeliveryState,
        isLiveMessage,
        receivedImage,
      ];
}
