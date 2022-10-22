import '../../../core/error/failures/failures.dart';
import '../../../core/utils/either.dart';
import '../entities/text_message/sent_text_message.dart';

abstract class MessagesRepository {
  const MessagesRepository();

  Future<Either<Failure, SentTextMessage>> sendTextMessage(
    SentTextMessage textMessage,
  );
}
