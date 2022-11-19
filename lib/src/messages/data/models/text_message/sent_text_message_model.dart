import '../../../../core/user/domain/entities/user.dart';
import '../../../domain/entities/sent_message_base.dart';
import '../../../domain/entities/text_message/sent_text_message.dart';
import '../../datasources/local/models/messages_collection_model.dart';
import '../../datasources/remote/models/remote_message_model.dart';
import '../message_model.dart';
import '../model_converter.dart';

class SentTextMessageModel extends SentTextMessage implements MessageModel {
  SentTextMessageModel({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.user,
    required super.localSentDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required super.textMessage,
  });

  factory SentTextMessageModel.fromEntity(SentTextMessage entityObject) {
    return SentTextMessageModel(
      localMessageId: entityObject.localMessageId,
      localSentDate: entityObject.localSentDate,
      messageDeliveryState: entityObject.messageDeliveryState,
      remoteCreationDate: entityObject.remoteCreationDate,
      user: entityObject.user,
      remoteMessageId: entityObject.remoteMessageId,
      textMessage: entityObject.textMessage,
    );
  }

  @override
  MessagesCollectionModel toLocalDBModel() {
    return buildLocalDBModel()
      ..textMessage = (TextMessage()..text = textMessage);
  }

  @override
  RemoteMessageModel toRemoteModel() {
    return buildRemoteModel()..textMessage = textMessage;
  }

  factory SentTextMessageModel.fromRemoteModel(
    RemoteMessageModel remoteModel,
  ) {
    return SentTextMessageModel(
      localMessageId: remoteModel.sentDate.microsecondsSinceEpoch,
      remoteMessageId: remoteModel.remoteMessageId,
      user: remoteModel.receiver,
      messageDeliveryState: SentMessageDeliveryState.values.byName(
        remoteModel.messageDeliveryState,
      ),
      localSentDate: remoteModel.sentDate,
      remoteCreationDate: remoteModel.remoteCreationDate,
      textMessage: remoteModel.textMessage!,
    );
  }

  factory SentTextMessageModel.fromLocalDBModel(
    MessagesCollectionModel localModel,
    User user,
  ) {
    return SentTextMessageModel(
      localMessageId: localModel.localMessageId,
      remoteMessageId: localModel.remoteMessageId,
      user: user,
      remoteCreationDate: localModel.remoteCreationDate,
      messageDeliveryState:
          localModel.sentMessageProperties!.sentMessageDeliveryState,
      localSentDate: localModel.localSentDate,
      textMessage: localModel.textMessage!.text,
    );
  }
}
