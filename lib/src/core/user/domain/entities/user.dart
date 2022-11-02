import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../utils/undefined.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String? profileImageURL;
  final File? profileImageFile;

  const User({
    required this.userId,
    required this.name,
    this.profileImageURL,
    this.profileImageFile,
  });
  
  User copyWith({
    String? userId,
    String? name,
    Object? profileImageURL = undefined,
    Object? profileImageFile = undefined,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      profileImageURL: isNotPassedParameter(profileImageURL)
          ? this.profileImageURL
          : (profileImageURL as String?),
      profileImageFile: isNotPassedParameter(profileImageFile)
          ? this.profileImageFile
          : (profileImageFile as File?),
    );
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        profileImageFile?.path,
        profileImageURL,
      ];
}
