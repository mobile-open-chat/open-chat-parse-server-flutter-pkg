import 'dart:io';

import '../../../../core/user/domain/entities/user.dart';
import '../../../domain/entities/image_message/image.dart' hide ImageMessage;
import '../../../domain/entities/image_message/sent_image_message.dart';
import '../../../domain/entities/messages_base.dart';
import '../../../domain/entities/sent_message_base.dart';
import '../../datasources/local/models/messages_collection_model.dart';
import '../../datasources/remote/models/remote_message_model.dart';
import '../../utils/enums.dart';
import '../message_model.dart';
import '../model_converter.dart';

class SentImageMessageModel extends SentImageMessage implements MessageModel {
  const SentImageMessageModel({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.user,
    required super.localSentDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required super.sentImage,
  });

  factory SentImageMessageModel.fromEntity(SentImageMessage entityObject) {
    return SentImageMessageModel(
      localMessageId: entityObject.localMessageId,
      localSentDate: entityObject.localSentDate,
      messageDeliveryState: entityObject.messageDeliveryState,
      remoteCreationDate: entityObject.remoteCreationDate,
      user: entityObject.user,
      remoteMessageId: entityObject.remoteMessageId,
      sentImage: entityObject.sentImage,
    );
  }

  @override
  MessagesCollectionModel toLocalDBModel() {
    final localImageMessage = ImageMessage()
      ..imageFilePath = sentImage.imageFile?.path
      ..thumbnailFilePath = sentImage.thumbnailFile?.path
      ..hight = sentImage.imageMetaData.hight
      ..width = sentImage.imageMetaData.width
      ..size = sentImage.imageMetaData.size;

    return buildLocalDBModel()
      ..messageType = MessageType.image.name
      ..imageMessage = localImageMessage;
  }

  @override
  RemoteMessageModel toRemoteModel() {
    return buildRemoteModel()
      ..messageType = MessageType.image
      ..remoteFile = sentImage.imageFile
      ..remoteFileURL = sentImage.imageURL
      ..metaData = sentImage.imageMetaData.toJson();
  }

  factory SentImageMessageModel.fromRemoteModel(
    RemoteMessageModel remoteModel,
  ) {
    final image = Image(
      imageMetaData: const ImageMetaData().fromJson(remoteModel.metaData),
      imageURL: remoteModel.remoteFileURL,
      thumbnailURL: remoteModel.thumbnailURL,
      imageFile: remoteModel.remoteFile,
      thumbnailFile: remoteModel.thumbnailFile,
    );

    return SentImageMessageModel(
      localMessageId: remoteModel.sentDate.microsecondsSinceEpoch,
      remoteMessageId: remoteModel.remoteMessageId,
      user: remoteModel.receiver,
      messageDeliveryState: SentMessageDeliveryState.values.byName(
        remoteModel.messageDeliveryState,
      ),
      localSentDate: remoteModel.sentDate,
      remoteCreationDate: remoteModel.remoteCreationDate,
      sentImage: image,
    );
  }

  factory SentImageMessageModel.fromLocalDBModel(
    MessagesCollectionModel localModel,
    User user,
  ) {
    final localImgMsg = localModel.imageMessage;
    final imagePath = localImgMsg?.imageFilePath;
    final thumbnailPath = localImgMsg?.thumbnailFilePath;

    final image = Image(
      imageMetaData: ImageMetaData(
        hight: localImgMsg?.hight,
        size: localImgMsg?.size,
        width: localImgMsg?.width,
      ),
      imageURL: localImgMsg?.imageURL,
      thumbnailURL: localImgMsg?.thumbnailURL,
      imageFile: imagePath != null ? File(imagePath) : null,
      thumbnailFile: thumbnailPath != null ? File(thumbnailPath) : null,
    );

    return SentImageMessageModel(
      localMessageId: localModel.localMessageId,
      remoteMessageId: localModel.remoteMessageId,
      user: user,
      remoteCreationDate: localModel.remoteCreationDate,
      messageDeliveryState:
          localModel.sentMessageProperties!.sentMessageDeliveryState,
      localSentDate: localModel.localSentDate,
      sentImage: image,
    );
  }
}
