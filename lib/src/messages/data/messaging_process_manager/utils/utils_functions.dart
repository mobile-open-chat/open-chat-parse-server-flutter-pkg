import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../../../core/error/exceptions/user_exception.dart';

enum FolderName {
  images,
}

String? _appDocumentsDirectory;
FutureOr<String> get appDocumentsDirectory async {
  return _appDocumentsDirectory ??=
      (await path_provider.getApplicationDocumentsDirectory()).path;
}

Future<bool> canSkipCopingFileToAppDocumentsDirectory(
  String filePath,
) async {
  final chatDirPath = path.join(await appDocumentsDirectory, 'chat');

  final isFileWithinChatDir = path.isWithin(chatDirPath, filePath);
  final isFileExists = await File(filePath).exists();

  if (isFileWithinChatDir && isFileExists) {
    return true;
  }
  return false;
}

Future<File> saveFileToAppDocumentsDirectory(
  File file,
  FolderName folderName,
) async {
  final dirPath =
      path.join(await appDocumentsDirectory, 'chat', folderName.name);

  await _createDirectory(dirPath);

  final filePath = path.join(dirPath, path.basename(file.path));

  final savedFile = await File(filePath).writeAsBytes(
    await file.readAsBytes(),
    flush: true,
  );

  if (!(await savedFile.exists())) {
    throw const ErrorWhileSavingTheFile(
      'file dose not exists when saving message',
    );
  }

  return savedFile;
}

Future<void> _createDirectory(String dirPath) async {
  try {
    await Directory(dirPath).create(recursive: true);
  } catch (e) {
    throw ErrorWhileSavingTheFile(
      'can not create app directory\n Error: $e',
    );
  }
}
