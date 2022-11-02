import 'messages_base.dart';

enum SentMessageDeliveryState {
  /// Not sent yet
  pending,

  /// Message sent successfully
  sent,

  /// Error while sending the message
  error,

  /// Message delivered to the other user
  delivered,

  /// The message was seen by the other user
  seen
}

abstract class SentMessageBase extends MessageBase {
  final SentMessageDeliveryState messageDeliveryState;

  const SentMessageBase({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.user,
    required super.localSentDate,
    required super.remoteCreationDate,
    required this.messageDeliveryState,
  });
}
