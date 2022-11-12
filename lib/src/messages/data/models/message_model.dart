import '../datasources/local/models/messages_collection_model.dart';
import '../datasources/remote/models/remote_message_model.dart';

abstract class MessageModel {
  MessagesCollectionModel toLocalDBModel();
  RemoteMessageModel toRemoteModel();
}
