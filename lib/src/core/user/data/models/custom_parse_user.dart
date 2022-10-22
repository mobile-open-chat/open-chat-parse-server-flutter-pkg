import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CustomParseUser extends ParseUser
    with EquatableMixin
    implements ParseCloneable {
  static const keyUserClassName = keyClassUser;
  static const keyName = 'name';
  static const keyProfileImage = 'profileImage';
  static const keyUniqueUserName = keyVarUsername;
  static const keyBlockedUsers = 'blockedUsers';
  static const keyEmail = ParseUser.keyEmailAddress;

  CustomParseUser(
    String? username,
    String? password,
    String? emailAddress, {
    ParseClient? client,
    bool? debug,
    String? sessionToken,
  }) : super(
          username,
          password,
          emailAddress,
          client: client,
          debug: debug,
          sessionToken: sessionToken,
        );

  CustomParseUser.clone(Map<String, dynamic> map)
      : this(
          map[keyVarUsername],
          map[keyVarPassword],
          map[keyVarEmail],
          sessionToken: map[keyVarSessionToken],
        );

  static buildUserPointer(String id) {
    return (CustomParseUser(null, null, null)..set(keyVarObjectId, id));
  }

  @override
  clone(Map<String, dynamic> map) => CustomParseUser.clone(map)..fromJson(map);

  String get name => get<String>(keyName) as String;
  set name(String name) => set<String>(keyName, name);

  String get userId => get<String>(keyVarObjectId) as String;

  ParseFile? get profileImage => get<ParseFile?>(keyProfileImage);

  set profileImage(ParseFile? profileImage) =>
      set<ParseFile?>(keyProfileImage, profileImage);

  List<String> getListOfBlockedUsers() =>
      List<String>.of(get(keyBlockedUsers)?.cast<String>() ?? []);

  @override
  List<Object?> get props => [
        get<String>(keyVarObjectId),
        emailAddress,
        username,
        get<String>(keyName),
        get<ParseFile>(keyProfileImage)?.url,
        get<ParseFile>(keyProfileImage)?.name,
      ];
}
