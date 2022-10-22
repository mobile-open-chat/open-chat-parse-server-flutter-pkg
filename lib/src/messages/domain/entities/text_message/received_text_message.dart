import '../../../../core/utils/undefined.dart';
import '../received_message_base.dart';

class ReceivedTextMessage extends ReceivedMessageBase {
  final String textMessage;

  const ReceivedTextMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.userId,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required super.isLiveMessage,
    required this.textMessage,
  });

  ReceivedTextMessage copyWith({
    int? localMessageId,
    Object? remoteMessageId = undefined,
    String? userId,
    DateTime? localSentDate,
    DateTime? localReceivedDate,
    Object? remoteCreationDate = undefined,
    ReceivedMessageDeliveryState? messageDeliveryState,
    bool? isLiveMessage,
    String? textMessage,
  }) {
    return ReceivedTextMessage(
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
      textMessage: textMessage ?? this.textMessage,
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
        textMessage
      ];
}
