import '../../../../core/utils/undefined.dart';
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

  SentTextMessage copyWith({
    String? localMessageId,
    Object? remoteMessageId = undefined,
    String? senderId,
    String? receiverId,
    DateTime? localSentDate,
    DateTime? localReceivedDate,
    Object? remoteSentDate = undefined,
    SentMessageDeliveryState? messageDeliveryState,
    String? textMessage,
  }) {
    return SentTextMessage(
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
      textMessage: textMessage ?? this.textMessage,
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
        textMessage
      ];
}
