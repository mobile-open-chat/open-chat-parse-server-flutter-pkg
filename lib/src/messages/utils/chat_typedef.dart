import '../../core/error/failures/failures.dart';
import '../../core/utils/either.dart';
import '../domain/entities/text_message/sent_text_message.dart';

typedef FailureOrSentTextMessage = Either<Failure, SentTextMessage>;
