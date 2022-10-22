import '../../../../core/utils/undefined.dart';
import '../sent_message_base.dart';
import 'image.dart';

class SentImageMessage extends SentMessageBase {
  final Image sentImage;

  const SentImageMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.userId,
    required super.localSentDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required this.sentImage,
  });

  SentImageMessage copyWith({
    int? localMessageId,
    Object? remoteMessageId = undefined,
    String? userId,
    DateTime? localSentDate,
    Object? remoteCreationDate = undefined,
    SentMessageDeliveryState? messageDeliveryState,
    Image? sentImage,
  }) {
    return SentImageMessage(
      localMessageId: localMessageId ?? this.localMessageId,
      remoteMessageId: isNotPassedParameter(remoteMessageId)
          ? this.remoteMessageId
          : (remoteMessageId as String?),
      userId: userId ?? this.userId,
      localSentDate: localSentDate ?? this.localSentDate,
      remoteCreationDate: isNotPassedParameter(remoteCreationDate)
          ? this.remoteCreationDate
          : (remoteCreationDate as DateTime?),
      messageDeliveryState: messageDeliveryState ?? this.messageDeliveryState,
      sentImage: sentImage ?? this.sentImage,
    );
  }

  @override
  List<Object?> get props => [
        localMessageId,
        remoteMessageId,
        userId,
        localSentDate,
        remoteCreationDate,
        messageDeliveryState,
        sentImage,
      ];
}
