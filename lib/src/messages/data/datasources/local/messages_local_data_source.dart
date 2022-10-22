import 'dart:developer';

import '../../../../core/database/isar_database.dart';
import 'models/messages_collection_model.dart';

abstract class MessagesLocalDataSource {
  const MessagesLocalDataSource();
  Future<bool> storeMessage(MessagesCollectionModel message);

  Future<bool> updateMessage(MessagesCollectionModel message);
}

class MessagesLocalDataSourceImpl extends MessagesLocalDataSource {
  final IsarDataBase _isarDataBase;

  const MessagesLocalDataSourceImpl(this._isarDataBase);
  @override
  Future<bool> storeMessage(MessagesCollectionModel message) async {
    try {
      await _isarDataBase.isar.Messages.put(message);
      return true;
    } catch (e) {
      log(
        'Error storing a message in isar local database',
        error: e.toString(),
      );
      return false;
    }
  }

  @override
  Future<bool> updateMessage(MessagesCollectionModel message) async {
    try {
      await _isarDataBase.isar.Messages.put(message);
      return true;
    } catch (e) {
      log(
        'Error updating a message in isar local database',
        error: e.toString(),
      );
      return false;
    }
  }
}
