import '../../../../core/user/domain/entities/user.dart';
import '../../../../core/utils/undefined.dart';
import '../sent_message_base.dart';
import 'image.dart';

class SentImageMessage extends SentMessageBase implements ImageMessage {
  final Image sentImage;

  const SentImageMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.user,
    required super.localSentDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required this.sentImage,
  });

  @override
  Image get image => sentImage;

  SentImageMessage copyWith({
    int? localMessageId,
    Object? remoteMessageId = undefined,
    User? user,
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
      user: user ?? this.user,
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
        user,
        localSentDate,
        remoteCreationDate,
        messageDeliveryState,
        sentImage,
      ];
}
