import '../../../domain/entities/received_message_base.dart';
import '../../../domain/entities/text_message/received_text_message.dart';
import '../../datasources/local/models/messages_collection_model.dart';
import '../../datasources/remote/models/remote_message_model.dart';
import '../../utils/enums.dart';
import '../model_converter.dart';

class ReceivedTextMessageModel extends ReceivedTextMessage
    with ReceivedMessageModelConverterMixin {
  const ReceivedTextMessageModel({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.userId,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required super.isLiveMessage,
    required super.textMessage,
  });

  @override
  MessagesCollectionModel toLocalDBModel() {
    return super.toLocalDBModel()
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
      userId: remoteModel.sender.userId,
      messageDeliveryState: ReceivedMessageDeliveryState.values.byName(
        remoteModel.messageDeliveryState,
      ),
      isLiveMessage: isLiveMessage,
      localSentDate: remoteModel.sentDate,
      localReceivedDate: DateTime.now(),
      remoteCreationDate: remoteModel.remoteCreationDate,
      textMessage: remoteModel.textMessage!,
    );
  }

  factory ReceivedTextMessageModel.fromLocalDBModel(
    MessagesCollectionModel localModel,
  ) {
    return ReceivedTextMessageModel(
      localMessageId: localModel.localMessageId,
      remoteMessageId: localModel.remoteMessageId,
      userId: localModel.userId,
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
}
