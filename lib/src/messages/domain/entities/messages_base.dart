import 'package:equatable/equatable.dart';

abstract class MessageBase extends Equatable {
  final int localMessageId;
  final String? remoteMessageId;
  final String senderId;
  final String receiverId;
  final DateTime localSentDate;
  final DateTime? remoteSentDate;

  const MessageBase({
    required this.localMessageId,
    required this.remoteMessageId,
    required this.senderId,
    required this.receiverId,
    required this.localSentDate,
    required this.remoteSentDate,
  });
}
