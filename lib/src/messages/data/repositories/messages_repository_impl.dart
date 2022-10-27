import '../../../core/data/process_manager_base/process_manager_base.dart';
import '../../../core/utils/either.dart';
import '../../domain/entities/image_message/image.dart';
import '../../domain/entities/image_message/sent_image_message.dart';
import '../../domain/entities/text_message/sent_text_message.dart';
import '../../domain/repositories/messages_repository.dart';
import '../../utils/chat_typedef.dart';
import '../datasources/local/messages_local_data_source.dart';
import '../datasources/remote/messages_remote_data_source.dart';
import '../messaging_process_manager/send_text_message_process_manager.dart'
    show ErrorOrMessage;

class MessageRepositoryImpl extends MessagesRepository {
  final MessagesLocalDataSource _messagesLocalDataSource;
  final MessagesRemoteDataSource _messagesRemoteDataSource;

  final ProcessManagerBase<Future<ErrorOrMessage>, SentTextMessage>
      _sendTextMessageProcessManager;

  final ProcessManagerBase<ValueStreamOfProgressOrSentImageMessage,
      SentImageMessage> _sendImageMessageProcessManager;

  final ProcessManagerBase<ValueStreamOfProgressOrImageMessage, ImageMessage>
      _downloadImageMessageProcessManager;

  const MessageRepositoryImpl(
    this._messagesLocalDataSource,
    this._messagesRemoteDataSource,
    this._sendTextMessageProcessManager,
    this._sendImageMessageProcessManager,
    this._downloadImageMessageProcessManager,
  );

  @override
  Future<FailureOrSentTextMessage> sendTextMessage(
    SentTextMessage textMessage,
  ) async {
    final result = await _sendTextMessageProcessManager
        .startOrAttachToRunningProcess(textMessage);

    return result.fold(
      (error) => Left(error.asFailure()),
      (message) => Right(message),
    );
  }

  @override
  ValueStreamOfProgressOrSentImageMessage sendImageMessage(
    SentImageMessage imageMessage,
  ) {
    return _sendImageMessageProcessManager
        .startOrAttachToRunningProcess(imageMessage);
  }

  @override
  ValueStreamOfProgressOrImageMessage downloadImageMessage(
    ImageMessage imageMessage,
  ) {
    return _downloadImageMessageProcessManager
        .startOrAttachToRunningProcess(imageMessage);
  }
}
