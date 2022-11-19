import '../../../../core/user/domain/entities/user.dart';
import '../../../../core/utils/undefined.dart';
import '../message_type.dart';
import '../received_message_base.dart';

class ReceivedTextMessage extends ReceivedMessageBase {
  final String textMessage;

  ReceivedTextMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.user,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required super.isLiveMessage,
    required this.textMessage,
  }) : super(messageType: MessageType.text.name);

  ReceivedTextMessage copyWith({
    int? localMessageId,
    Object? remoteMessageId = undefined,
    User? user,
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
      user: user ?? this.user,
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
        user,
        localSentDate,
        localReceivedDate,
        remoteCreationDate,
        messageDeliveryState,
        isLiveMessage,
        textMessage
      ];
}
