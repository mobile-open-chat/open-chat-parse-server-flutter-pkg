import 'package:equatable/equatable.dart';
import 'package:flutter_parse_chat/src/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/either.dart';
import '../../entities/sent_message_base.dart';
import '../../entities/text_message/sent_text_message.dart';
import '../../repositories/messages_repository.dart';

class SendTextMessage
    implements UseCase<SentTextMessage, SendTextMessageParams> {
  final MessagesRepository _messagesRepository;

  SendTextMessage(this._messagesRepository);
  @override
  Future<Either<Failure, SentTextMessage>> call(
    SendTextMessageParams params,
  ) async {
    final senderIdResult = await _messagesRepository.getCurrentUserId();
    String senderId;

    if (senderIdResult.isLeft()) {
      return Left(senderIdResult.getLeftValue());
    } else {
      senderId = senderIdResult.getRightValue();
    }
    final dateTimeNow = DateTime.now();
    var message = SentTextMessage(
      localMessageId: -1,
      senderId: senderId,
      localSentDate: dateTimeNow,
      receiverId: params.receiverId,
      messageDeliveryState: SentMessageDeliveryState.pending,
      textMessage: params.textMessage,
      remoteMessageId: null,
      remoteSentDate: null,
    );

    if (params.localMessageId == null) {
      message =
          message.copyWith(localMessageId: dateTimeNow.microsecondsSinceEpoch);
      // send the message and return immediately to show the user that the message
      // sending in progress.
      _messagesRepository.sentTextMessage(message);
      return Right(message);
    } else {
      return _messagesRepository.sentTextMessage(message);
    }
  }
}

class SendTextMessageParams extends Equatable {
  final String textMessage;
  final String receiverId;
  final String? localMessageId;

  const SendTextMessageParams({
    required this.textMessage,
    required this.receiverId,
    required this.localMessageId,
  });

  @override
  List<Object?> get props => [
        textMessage,
        receiverId,
        localMessageId,
      ];
}
