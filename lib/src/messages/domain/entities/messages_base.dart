import 'package:equatable/equatable.dart';

import '../../../core/user/domain/entities/user.dart';

abstract class MessageBase extends Equatable {
  final int localMessageId;
  final String? remoteMessageId;
  final User user;
  final DateTime localSentDate;
  final DateTime? remoteCreationDate;

  const MessageBase({
    required this.localMessageId,
    required this.remoteMessageId,
    required this.user,
    required this.localSentDate,
    required this.remoteCreationDate,
  });
}
