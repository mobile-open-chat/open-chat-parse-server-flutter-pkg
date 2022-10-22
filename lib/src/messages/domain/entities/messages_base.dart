import 'package:equatable/equatable.dart';

abstract class MessageBase extends Equatable {
  final int localMessageId;
  final String? remoteMessageId;
  final String userId;
  final DateTime localSentDate;
  final DateTime? remoteCreationDate;

  const MessageBase({
    required this.localMessageId,
    required this.remoteMessageId,
    required this.userId,
    required this.localSentDate,
    required this.remoteCreationDate,
  });
}
