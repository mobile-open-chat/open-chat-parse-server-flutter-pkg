import 'package:rxdart/rxdart.dart';

import '../../core/error/failures/failures.dart';
import '../../core/utils/either.dart';
import '../domain/entities/image_message/sent_image_message.dart';
import '../domain/entities/text_message/sent_text_message.dart';
import 'progress.dart';

typedef FailureOrSentTextMessage = Either<Failure, SentTextMessage>;

typedef ValueStreamOfProgressOrImageMessage
    = ValueStream<Either<Progress, SentImageMessage>>;

typedef StreamOfProgressOrImageMessage
    = Stream<Either<Progress, SentImageMessage>>;
