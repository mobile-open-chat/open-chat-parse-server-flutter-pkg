import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../messages/data/datasources/local/models/messages_collection_model.dart';


class IsarDataBase {
  final String userId;
  late Isar? _isar;

  IsarDataBase(this.userId);

  Future<Isar> connect() async {
    String? dbPath;
    if (Platform.isAndroid || Platform.isIOS) {
      if (Platform.isIOS) {
        dbPath = (await path_provider.getLibraryDirectory()).path;
      } else {
        dbPath = (await path_provider.getApplicationDocumentsDirectory()).path;
      }
      dbPath = path.join(dbPath, 'database', userId);
      await Directory(dbPath).create(recursive: true);
    }

    return _isar ??= await Isar.open(
      [MessagesCollectionModelSchema],
      directory: dbPath,
      name: userId,
      compactOnLaunch: CompactCondition(),
    );
  }

  Isar get isar => _isar!;
}
