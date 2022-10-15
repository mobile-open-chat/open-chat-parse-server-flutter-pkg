import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/utils/undefined.dart';

class Image extends Equatable {
  final String? thumbnailURL;
  final File? thumbnailFile;

  final String? imageURL;
  final File? imageFile;

  const Image({
    required this.thumbnailURL,
    required this.thumbnailFile,
    required this.imageURL,
    required this.imageFile,
  });

  Image copyWith({
    Object? thumbnailURL = undefined,
    Object? thumbnailFile = undefined,
    Object? imageURL = undefined,
    Object? imageFile = undefined,
  }) {
    return Image(
      thumbnailURL: isNotPassedParameter(thumbnailURL)
          ? this.thumbnailURL
          : (thumbnailURL as String?),
      thumbnailFile: isNotPassedParameter(thumbnailFile)
          ? this.thumbnailFile
          : (thumbnailFile as File?),
      imageURL: isNotPassedParameter(imageURL)
          ? this.imageURL
          : (imageURL as String?),
      imageFile: isNotPassedParameter(imageFile)
          ? this.imageFile
          : (imageFile as File?),
    );
  }

  @override
  List<Object?> get props => [
        thumbnailURL,
        thumbnailFile,
        imageURL,
        imageFile,
      ];
}
