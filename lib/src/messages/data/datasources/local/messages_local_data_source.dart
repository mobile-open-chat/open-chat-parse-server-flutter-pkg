import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart' show compute;
import 'package:image/image.dart' as image;
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;

import '../../../../core/database/isar_database.dart';
import '../../messaging_process_manager/utils/utils_functions.dart';
import '../../utils/enums.dart';
import 'models/messages_collection_model.dart';

abstract class MessagesLocalDataSource {
  const MessagesLocalDataSource();
  Future<bool> storeMessage(MessagesCollectionModel message);

  Future<bool> updateMessage(MessagesCollectionModel message);

  String getDBPath();

  Future<MessagesCollectionModel> getMessageByLocalId(int messageId);

  Future<DateTime?> getLastReceivedMessageDate();

  Future<void> locallyGenerateImageThumbnailAndStoreIt(
    int localMessageId,
    String appDocumentsDirectory,
  );
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

  @override
  String getDBPath() {
    return _isarDataBase.isar.path!;
  }

  @override
  Future<MessagesCollectionModel> getMessageByLocalId(int messageId) async {
    return (await _isarDataBase.isar.Messages
        .where()
        .localMessageIdEqualTo(messageId)
        .findFirst())!;
  }

  @override
  Future<DateTime?> getLastReceivedMessageDate() async {
    return _isarDataBase.isar.Messages
        .where(sort: Sort.desc)
        .receivedMessageDeliveryStateForLocalDBNotEqualTo(
          ReceivedMessageDeliveryStateForLocalDB.nil,
        )
        .limit(1)
        .remoteCreationDateProperty()
        .findFirst();
  }

  @override
  Future<void> locallyGenerateImageThumbnailAndStoreIt(
    int localMessageId,
    String appDocumentsDirectory,
  ) async {
    final imagesDir = path.join(
      appDocumentsDirectory,
      FolderName.images.name,
    );

    await compute(_computeExecuter, [
      imagesDir,
      _isarDataBase.isar.directory,
      _isarDataBase.isar.name,
      localMessageId
    ]);
  }
}

Future<void> _computeExecuter(List args) async {
  final imagesDir = args[0] as String;

  final isarDir = args[1] as String;
  final isarInstanceName = args[2] as String;

  final localMessageId = args[3] as int;

  final isarDB = Isar.openSync(
    [MessagesCollectionModelSchema],
    directory: isarDir,
    name: isarInstanceName,
  );

  var message = isarDB.Messages.where()
      .localMessageIdEqualTo(localMessageId)
      .findFirstSync();
  if (message == null) {
    return;
  }

  final imageFile = File(message.imageMessage!.imageFilePath!);

  // compression start
  final decodedImage = image.decodeImage(imageFile.readAsBytesSync())!;
  var thumbnailImage = image.copyResize(
    decodedImage,
    height: 50,
  );
  thumbnailImage = image.gaussianBlur(thumbnailImage, 5);

  final thumbnailFilePath = path.join(
    imagesDir,
    'thumbnail-${path.basenameWithoutExtension(imageFile.path)}.png',
  );
  final thumbnailImageFile = File(thumbnailFilePath);
  thumbnailImageFile.writeAsBytesSync(
    image.encodePng(thumbnailImage),
    flush: true,
  );
  // compression End

  if (!thumbnailImageFile.existsSync()) {
    return;
  }

  // because this operation can take some time we need to check if the message
  // is still in the database and not deleted
  message = isarDB.Messages.where()
      .localMessageIdEqualTo(localMessageId)
      .findFirstSync();
  if (message == null) {
    thumbnailImageFile.deleteSync();
    return;
  }

  message.imageMessage!.thumbnailFilePath = thumbnailImageFile.path;
  isarDB.Messages.putSync(message);

  await isarDB.close();
}
