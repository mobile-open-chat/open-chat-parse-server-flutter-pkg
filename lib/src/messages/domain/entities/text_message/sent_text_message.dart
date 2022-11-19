import '../../../../core/user/domain/entities/user.dart';
import '../../../../core/utils/undefined.dart';
import '../message_type.dart';
import '../sent_message_base.dart';

class SentTextMessage extends SentMessageBase {
  final String textMessage;

  SentTextMessage({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.user,
    required super.localSentDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required this.textMessage,
  }) : super(messageType: MessageType.text.name);

  SentTextMessage copyWith({
    int? localMessageId,
    Object? remoteMessageId = undefined,
    User? user,
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
      user: user ?? this.user,
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
        user,
        localSentDate,
        remoteCreationDate,
        messageDeliveryState,
        textMessage
      ];
}
