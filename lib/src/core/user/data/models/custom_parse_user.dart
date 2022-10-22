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

  // ignore: cast_nullable_to_non_nullable
  String get userId => get<String>(keyVarObjectId) as String;

  ParseFile? get profileImage => get<ParseFile?>(keyProfileImage);

  set profileImage(ParseFile? profileImage) =>
      set<ParseFile?>(keyProfileImage, profileImage);

  List<String> getListOfBlockedUsers() {
    return List<String>.of(
      get<List<dynamic>?>(keyBlockedUsers)?.cast<String>() ?? [],
    );
  }

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
