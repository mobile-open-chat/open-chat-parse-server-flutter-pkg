import '../../../core/error/failures/failures.dart';
import '../../../core/utils/either.dart';
import '../../domain/entities/text_message/sent_text_message.dart';
import '../../domain/repositories/messages_repository.dart';
import '../datasources/local/messages_local_data_source.dart';
import '../datasources/remote/messages_remote_data_source.dart';
import '../messaging_process_manager/send_text_message_process_manager.dart';

class MessageRepositoryImpl extends MessagesRepository {
  final MessagesLocalDataSource _messagesLocalDataSource;
  final MessagesRemoteDataSource _messagesRemoteDataSource;
  final SendTextMessageProcessManager _sendTextMessageProcessManager;
  const MessageRepositoryImpl(
    this._messagesLocalDataSource,
    this._messagesRemoteDataSource,
    this._sendTextMessageProcessManager,
  );

  @override
  Future<Either<Failure, SentTextMessage>> sendTextMessage(
    SentTextMessage textMessage,
  ) async {
    final result = await _sendTextMessageProcessManager
        .startOrAttachToRunningProcess(textMessage);

    return result.fold(
      (error) => Left(error.asFailure()),
      (message) => Right(message),
    );
  }
}
