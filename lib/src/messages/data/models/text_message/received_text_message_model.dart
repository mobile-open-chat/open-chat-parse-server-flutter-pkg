import '../../../../core/user/domain/entities/user.dart';
import '../../../domain/entities/received_message_base.dart';
import '../../../domain/entities/text_message/received_text_message.dart';
import '../../datasources/local/models/messages_collection_model.dart';
import '../../datasources/remote/models/remote_message_model.dart';
import '../../utils/enums.dart';
import '../message_model.dart';
import '../model_converter.dart';

class ReceivedTextMessageModel extends ReceivedTextMessage
    implements MessageModel {
  const ReceivedTextMessageModel({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.user,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required super.isLiveMessage,
    required super.textMessage,
  });

  @override
  MessagesCollectionModel toLocalDBModel() {
    return buildLocalDBModel()
      ..messageType = MessageType.text.name
      ..textMessage = (TextMessage()..text = textMessage);
  }

  factory ReceivedTextMessageModel.fromRemoteModel({
    required RemoteMessageModel remoteModel,
    required bool isLiveMessage,
  }) {
    return ReceivedTextMessageModel(
      localMessageId: remoteModel.sentDate.microsecondsSinceEpoch,
      remoteMessageId: remoteModel.remoteMessageId,
      user: remoteModel.sender,
      messageDeliveryState: ReceivedMessageDeliveryState.values.byName(
        remoteModel.messageDeliveryState,
      ),
      isLiveMessage: isLiveMessage,
      localSentDate: remoteModel.sentDate,
      localReceivedDate: DateTime.now().toUtc(),
      remoteCreationDate: remoteModel.remoteCreationDate,
      textMessage: remoteModel.textMessage!,
    );
  }

  factory ReceivedTextMessageModel.fromLocalDBModel(
    MessagesCollectionModel localModel,
    User user,
  ) {
    return ReceivedTextMessageModel(
      localMessageId: localModel.localMessageId,
      remoteMessageId: localModel.remoteMessageId,
      user: user,
      remoteCreationDate: localModel.remoteCreationDate,
      messageDeliveryState: localModel.receivedMessageDeliveryStateForLocalDB
          .toEntityDeliveryStateEnum(),
      localReceivedDate:
          localModel.receivedMessageProperties!.localReceivedDate,
      isLiveMessage: false,
      localSentDate: localModel.localSentDate,
      textMessage: localModel.textMessage!.text,
    );
  }

  @override
  RemoteMessageModel toRemoteModel() {
    throw UnimplementedError();
  }
}
