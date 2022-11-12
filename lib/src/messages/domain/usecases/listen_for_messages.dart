import '../../../core/usecases/usecase.dart';
import '../entities/messages_base.dart';
import '../repositories/messages_repository.dart';

class ListenForMessages implements UseCase<NoParams, Stream<MessageBase>> {
  final MessagesRepository _messagesRepository;

  ListenForMessages(this._messagesRepository);

  @override
  Stream<MessageBase> call(_) {
    return _messagesRepository.listenForMessages();
  }
}
