import 'dart:io';

import '../../../utils/undefined.dart';
import 'user.dart';

class CurrentUser extends User {
  final Set<String> blockedUsersIDs;
  final Set<String> chatUsersIDs;
  
  const CurrentUser({
    required super.userId,
    required super.name,
    super.profileImageFile,
    super.profileImageURL,
    required this.blockedUsersIDs,
    required this.chatUsersIDs,
  });

  @override
  CurrentUser copyWith({
    String? userId,
    String? name,
    Object? profileImageURL = undefined,
    Object? profileImageFile = undefined,
    Set<String>? blockedUsersIDs,
    Set<String>? chatUsersIDs,
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
      chatUsersIDs: chatUsersIDs ?? this.chatUsersIDs,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        blockedUsersIDs,
        chatUsersIDs,
      ];
}
