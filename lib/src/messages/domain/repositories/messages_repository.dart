
import '../../../core/error/failures.dart';
import '../../../core/utils/either.dart';
import '../entities/text_message/sent_text_message.dart';

abstract class MessagesRepository {
  Future<Either<Failure, SentTextMessage>> sentTextMessage(
    SentTextMessage textMessage,
  );

   Future<Either<Failure, String>> getCurrentUserId();
}
