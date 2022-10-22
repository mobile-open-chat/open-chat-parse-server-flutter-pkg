import '../../../../core/utils/undefined.dart';
import '../sent_message_base.dart';

class SentTextMessage extends SentMessageBase {
  final String textMessage;

  const SentTextMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.userId,
    required super.localSentDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required this.textMessage,
  });

  SentTextMessage copyWith({
    int? localMessageId,
    Object? remoteMessageId = undefined,
    String? userId,
    DateTime? localSentDate,
    Object? remoteCreationDate = undefined,
    SentMessageDeliveryState? messageDeliveryState,
    String? textMessage,
  }) {
    return SentTextMessage(
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
      textMessage: textMessage ?? this.textMessage,
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
        textMessage
      ];
}
