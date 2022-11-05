import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;

class CustomParseUser extends ParseUser
    with EquatableMixin
    implements ParseCloneable {
  static const keyUserClassName = keyClassUser;
  static const keyName = 'name';
  static const keyProfileImage = 'profileImage';
  static const keyUniqueUserName = keyVarUsername;
  static const keyBlockedUsersArray = 'blockedUsersArray';
  static const keyBlockedUsersRelation = 'blockedUsersRelation';
  static const keyChatUsersArray = 'chatUsersArray';
  static const keyChatUsersRelation = 'chatUsersRelation';
  static const keyEmail = ParseUser.keyEmailAddress;

  CustomParseUser(
    super.username,
    super.password,
    super.emailAddress, {
    super.client,
    super.debug,
    super.sessionToken,
  });

  CustomParseUser.clone(Map<String, dynamic> map)
      : this(
          map[keyVarUsername] as String?,
          map[keyVarPassword] as String?,
          map[keyVarEmail] as String?,
          sessionToken: map[keyVarSessionToken] as String?,
        );

  factory CustomParseUser.buildUserPointer(String id) {
    return (CustomParseUser(null, null, null)..set(keyVarObjectId, id));
  }

  @override
  CustomParseUser clone(Map<String, dynamic> map) =>
      CustomParseUser.clone(map)..fromJson(map);

  String get name => get<String>(keyName) ?? 'Unknown';
  set name(String name) => set<String>(keyName, name);

  String get userId => get(keyVarObjectId) as String;

  File? get profileImageFile => get<ParseFile?>(keyProfileImage)?.file;
  set profileImageFile(File? file) {
    final parseFile = get<ParseFile?>(keyProfileImage) ?? ParseFile(file);
    parseFile.file = file;
    set(keyProfileImage, parseFile);
  }

  String? get profileImageURL => get<ParseFile?>(keyProfileImage)?.url;
  set profileImageURL(String? url) {
    final parseFile = get<ParseFile?>(keyProfileImage) ??
        ParseFile(
          null,
          name: path.basename(url!),
        );

    parseFile.url = url;

    set(keyProfileImage, parseFile);
  }

  Set<String> getBlockedUsersIDs() {
    return Set<String>.of(
      get<List<dynamic>?>(keyBlockedUsersArray)?.cast<String>() ?? [],
    );
  }

  Set<String> getChatUsersIDs() {
    return Set<String>.of(
      get<List<dynamic>?>(keyChatUsersArray)?.cast<String>() ?? [],
    );
  }

  @override
  List<Object?> get props => [
        get<String?>(keyVarObjectId),
        username,
        emailAddress,
        get<String?>(keyName),
        get<List>(keyChatUsersArray),
        get<List>(keyBlockedUsersArray),
        get<ParseFile?>(keyProfileImage)?.url,
        get<ParseFile?>(keyProfileImage)?.name,
      ];
}
