import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/user/domain/entities/user.dart';
import '../../../../core/utils/either.dart';
import '../../../utils/chat_typedef.dart';
import '../../entities/sent_message_base.dart';
import '../../entities/text_message/sent_text_message.dart';
import '../../repositories/messages_repository.dart';

class SendTextMessage
    implements
        UseCase<SendTextMessageParams, Future<FailureOrSentTextMessage>> {
  final MessagesRepository _messagesRepository;

  SendTextMessage(this._messagesRepository);

  @override
  Future<FailureOrSentTextMessage> call(
    SendTextMessageParams params,
  ) async {
    final dateTime = DateTime.now().toUtc();

    var message = SentTextMessage(
      localMessageId: -1,
      localSentDate: dateTime,
      user: params.receiver,
      messageDeliveryState: SentMessageDeliveryState.pending,
      textMessage: params.textMessage,
      remoteMessageId: null,
      remoteCreationDate: null,
    );

    if (params.localMessageId == null) {
      message = message.copyWith(
        localMessageId: dateTime.microsecondsSinceEpoch,
      );
      // send the message and return immediately to show the user that the message
      // sending in progress.
      _messagesRepository.sendTextMessage(message);
      return Right(message);
    } else {
      message = message.copyWith(
        localMessageId: params.localMessageId,
      );
      return _messagesRepository.sendTextMessage(message);
    }
  }
}

class SendTextMessageParams extends Equatable {
  final String textMessage;
  final User receiver;
  final int? localMessageId;

  const SendTextMessageParams({
    required this.textMessage,
    required this.receiver,
    required this.localMessageId,
  });

  @override
  List<Object?> get props => [
        textMessage,
        receiver,
        localMessageId,
      ];
}
