import '../../../../core/usecases/usecase.dart';
import '../../../utils/chat_typedef.dart';
import '../../entities/image_message/image.dart';
import '../../repositories/messages_repository.dart';

class DownloadImageMessage
    implements UseCase<ImageMessage, ValueStreamOfProgressOrImageMessage> {
  final MessagesRepository _messagesRepository;

  DownloadImageMessage(this._messagesRepository);

  @override
  ValueStreamOfProgressOrImageMessage call(ImageMessage params) {
    return _messagesRepository.downloadImageMessage(params);
  }
}
