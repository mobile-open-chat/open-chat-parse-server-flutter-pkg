import '../../domain/entities/received_message_base.dart';

enum MessageType { text, image }

/// #### Don't change the order of the properties
/// the index of the property is stored in the DB
enum ReceivedMessageDeliveryStateForLocalDB {
  /// Dummy value to set it for sent messages
  nil,

  /// The init value ware the message was sent to the server
  sent,

  /// The current user received the message
  delivered,

  /// The current user opened the message
  seen;

  ReceivedMessageDeliveryState toEntityDeliveryStateEnum() {
    return ReceivedMessageDeliveryState.values.byName(name);
  }
}

extension ToDataBaseModelDeliveryStateEnum on ReceivedMessageDeliveryState {
  ReceivedMessageDeliveryStateForLocalDB toDataBaseModelDeliveryStateEnum() {
    return ReceivedMessageDeliveryStateForLocalDB.values.byName(name);
  }
}
