import 'package:equatable/equatable.dart';

abstract class MessageBase extends Equatable {
  final String localMessageId;
  final String? remoteMessageId;
  final String senderId;
  final String receiverId;
  final DateTime localSentDate;
  final DateTime localReceivedDate;
  final DateTime? remoteSentDate;

  const MessageBase({
    required this.localMessageId,
    required this.remoteMessageId,
    required this.senderId,
    required this.receiverId,
    required this.localSentDate,
    required this.localReceivedDate,
    required this.remoteSentDate,
  });
}
