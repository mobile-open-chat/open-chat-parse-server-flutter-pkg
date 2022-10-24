import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../../../core/user/data/models/custom_parse_user.dart';
import '../../../utils/enums.dart';

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

  ParseFile? get remoteFile => get(keyFile) as ParseFile?;
  set remoteFile(ParseFile? parseFile) => set(keyFile, parseFile);

  ParseFile? get thumbnail => get(keyThumbnail) as ParseFile?;

  String get receivedMessageType => get(keyMessageType) as String;

  // ignore: avoid_setters_without_getters
  set messageType(MessageType messageType) =>
      set(keyMessageType, messageType.name);

  DateTime get sentDate => get(keyLocalSentDate) as DateTime;
  set sentDate(DateTime sentDate) => set(keyLocalSentDate, sentDate);

  CustomParseUser get sender => get(keySender) as CustomParseUser;

  CustomParseUser get receiver => get(keyReceiver) as CustomParseUser;
  set receiver(CustomParseUser receiver) => set(keyReceiver, receiver);

  String get messageDeliveryState => get(keyText) as String;
  set messageDeliveryState(String textMessage) => set(keyText, textMessage);

  Map<String, dynamic> get metaData =>
      jsonDecode(get<String>(keyMetaData)!) as Map<String, dynamic>;
  set metaData(Map<String, dynamic> metaData) =>
      set(keyMetaData, jsonEncode(metaData));

  DateTime get remoteCreationDate => get(keyRemoteCreationDate) as DateTime;

  @override
  List<Object?> get props => [
        get(keyRemoteMessageId),
        textMessage,
        remoteFile,
        receivedMessageType,
        sentDate,
        sender,
        receiver,
        metaData,
      ];
}
