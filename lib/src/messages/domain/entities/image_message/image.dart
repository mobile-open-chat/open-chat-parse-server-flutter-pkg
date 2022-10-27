import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../../core/utils/undefined.dart';

abstract class ImageMessage {
  final Image image;

  ImageMessage(this.image);
}

class Image extends Equatable {
  final String? thumbnailURL;
  final File? thumbnailFile;

  final String? imageURL;
  final File? imageFile;

  final ImageMetaData imageMetaData;
  const Image({
    required this.imageMetaData,
    this.thumbnailURL,
    this.thumbnailFile,
    this.imageURL,
    this.imageFile,
  });

  Image copyWith({
    Object? thumbnailURL = undefined,
    Object? thumbnailFile = undefined,
    Object? imageURL = undefined,
    Object? imageFile = undefined,
    ImageMetaData? imageMetaData,
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
      imageMetaData: imageMetaData ?? this.imageMetaData,
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

class ImageMetaData extends Equatable {
  final int? hight;
  final int? width;

  final int? size;

  const ImageMetaData({
    this.hight,
    this.width,
    this.size,
  });

  ImageMetaData copyWith({
    Object? hight = undefined,
    Object? width = undefined,
    Object? size = undefined,
  }) {
    return ImageMetaData(
      hight: isNotPassedParameter(hight) ? this.hight : (hight as int?),
      width: isNotPassedParameter(width) ? this.width : (width as int?),
      size: isNotPassedParameter(size) ? this.size : (size as int?),
    );
  }

  @override
  List<Object?> get props => [
        hight,
        width,
        size,
      ];
}
