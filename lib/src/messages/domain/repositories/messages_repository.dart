import '../../utils/chat_typedef.dart';
import '../entities/image_message/sent_image_message.dart';
import '../entities/text_message/sent_text_message.dart';

abstract class MessagesRepository {
  const MessagesRepository();

  Future<FailureOrSentTextMessage> sendTextMessage(
    SentTextMessage textMessage,
  );

    ValueStreamOfProgressOrImageMessage sendImageMessage(
    SentImageMessage imageMessage,
  );
}
