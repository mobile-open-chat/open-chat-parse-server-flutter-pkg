import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import "package:path/path.dart" as path;

import '../../../../../core/user/data/models/custom_parse_user.dart';
import '../../../../../core/user/domain/entities/user.dart';
import '../../../../domain/entities/message_type.dart';

class RemoteMessageModel extends ParseObject with EquatableMixin {
  RemoteMessageModel() : super.clone(keyClassName);

  // ignore: avoid_unused_constructor_parameters
  RemoteMessageModel.clone(Map map) : this();

  @override
  RemoteMessageModel clone(Map<String, dynamic> map) =>
      RemoteMessageModel.clone(map)..fromJson(map);

  static const keyClassName = 'Messages';

  static const keyRemoteMessageId = keyVarObjectId;
  static const keyText = 'text';
  static const keyFile = 'file';
  static const keyThumbnail = 'thumbnail';
  static const keyMessageType = 'messageType';
  static const keyLocalSentDate = 'localSentDate';
  static const keySender = 'sender';
  static const keyReceiver = 'receiver';
  static const keyMetaData = 'mateData';
  static const keyMessageDeliveryState = 'messageDeliveryState';
  static const keyRemoteCreationDate = keyVarCreatedAt;

  String get remoteMessageId => get(keyRemoteMessageId) as String;

  String? get textMessage => get(keyText) as String?;
  set textMessage(String? textMessage) => set(keyText, textMessage);

  File? get remoteFile => get<ParseFile?>(keyFile)?.file;
  set remoteFile(File? file) {
    final parseFile = get<ParseFile?>(keyFile) ?? ParseFile(file);
    parseFile.file = file;
    set(keyFile, parseFile);
  }

  String? get remoteFileURL => get<ParseFile?>(keyFile)?.url;
  set remoteFileURL(String? url) {
    final parseFile = get<ParseFile?>(keyFile) ??
        ParseFile(
          null,
          name: path.basename(url!),
        );

    parseFile.url = url;

    set(keyFile, parseFile);
  }

  File? get thumbnailFile => get<ParseFile?>(keyThumbnail)?.file;
  String? get thumbnailURL => get<ParseFile?>(keyThumbnail)?.url;

  String get receivedMessageType => get(keyMessageType) as String;

  // ignore: avoid_setters_without_getters
  set messageType(MessageType messageType) =>
      set(keyMessageType, messageType.name);

  DateTime get sentDate => get(keyLocalSentDate) as DateTime;
  set sentDate(DateTime sentDate) => set(keyLocalSentDate, sentDate);

  User get sender => (get(keySender) as CustomParseUser).toUserEntityObject();

  User get receiver =>
      (get(keyReceiver) as CustomParseUser).toUserEntityObject();
  set receiver(User receiver) =>
      set(keyReceiver, CustomParseUser.buildUserPointer(receiver.userId));

  String get messageDeliveryState => get(keyMessageDeliveryState) as String;
  set messageDeliveryState(String deliveryState) =>
      set(keyMessageDeliveryState, deliveryState);

  Map<String, dynamic> get metaData =>
      jsonDecode(get<String>(keyMetaData)!) as Map<String, dynamic>;
  set metaData(Map<String, dynamic> metaData) =>
      set(keyMetaData, jsonEncode(metaData));

  DateTime get remoteCreationDate => get(keyRemoteCreationDate) as DateTime;

  bool isTextMessage() {
    return receivedMessageType == MessageType.text.name;
  }

  bool isImageMessage() {
    return receivedMessageType == MessageType.image.name;
  }

  bool isReceivedMessage(String currentUserId) {
    return receiver.userId == currentUserId;
  }

  @override
  List<Object?> get props => [
        get(keyRemoteMessageId),
        get(keyText),
        get<ParseFile?>(keyFile)?.url,
        get<ParseFile?>(keyFile)?.file?.path,
        get(keyMessageType),
        get(keyLocalSentDate),
        get(keySender),
        get(keyReceiver),
        get(keyMetaData),
        get(keyRemoteCreationDate)
      ];
}

extension _ToCurrentUser on CustomParseUser {
  User toUserEntityObject() {
    return User(
      userId: userId,
      name: name,
      profileImageFile: profileImageFile,
      profileImageURL: profileImageURL,
    );
  }
}
