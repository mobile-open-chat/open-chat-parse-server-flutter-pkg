import 'dart:io';

import '../../../utils/undefined.dart';
import 'user.dart';

class CurrentUser extends User {
  final Set<String> blockedUsersIDs;
  const CurrentUser({
    required super.userId,
    required super.name,
    super.profileImageFile,
    super.profileImageURL,
    required this.blockedUsersIDs,
  });

  @override
  CurrentUser copyWith({
    String? userId,
    String? name,
    Object? profileImageURL = undefined,
    Object? profileImageFile = undefined,
    Set<String>? blockedUsersIDs,
  }) {
    return CurrentUser(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      profileImageURL: isNotPassedParameter(profileImageURL)
          ? this.profileImageURL
          : (profileImageURL as String?),
      profileImageFile: isNotPassedParameter(profileImageFile)
          ? this.profileImageFile
          : (profileImageFile as File?),
      blockedUsersIDs: blockedUsersIDs ?? this.blockedUsersIDs,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        blockedUsersIDs,
      ];
}
