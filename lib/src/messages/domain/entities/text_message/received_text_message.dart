import '../../../../core/utils/undefined.dart';
import '../received_message_base.dart';

class ReceivedTextMessage extends ReceivedMessageBase {
  final String textMessage;

  const ReceivedTextMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.senderId,
    required super.receiverId,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteSentDate,
    required super.messageDeliveryState,
    required super.isLiveMessage,
    required this.textMessage,
  });

  ReceivedTextMessage copyWith({
    String? localMessageId,
    Object? remoteMessageId = undefined,
    String? senderId,
    String? receiverId,
    DateTime? localSentDate,
    DateTime? localReceivedDate,
    Object? remoteSentDate = undefined,
    ReceivedMessageDeliveryState? messageDeliveryState,
    bool? isLiveMessage,
    String? textMessage,
  }) {
    return ReceivedTextMessage(
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
        isLiveMessage,
        textMessage
      ];
}
