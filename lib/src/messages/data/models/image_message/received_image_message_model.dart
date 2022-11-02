import 'dart:io';

import '../../../../core/user/domain/entities/user.dart';
import '../../../domain/entities/image_message/image.dart' hide ImageMessage;
import '../../../domain/entities/image_message/received_image_message.dart';
import '../../../domain/entities/received_message_base.dart';
import '../../datasources/local/models/messages_collection_model.dart';
import '../../datasources/remote/models/remote_message_model.dart';
import '../../utils/enums.dart';
import '../model_converter.dart';

class ReceivedImageMessageModel extends ReceivedImageMessage
    with ReceivedMessageModelConverterMixin {
  const ReceivedImageMessageModel({
    required super.localMessageId,
    required super.remoteMessageId,
    required super.user,
    required super.localSentDate,
    required super.localReceivedDate,
    required super.remoteCreationDate,
    required super.messageDeliveryState,
    required super.isLiveMessage,
    required super.receivedImage,
  });

  factory ReceivedImageMessageModel.fromEntity(
    ReceivedImageMessage entityObject,
  ) {
    return ReceivedImageMessageModel(
      localMessageId: entityObject.localMessageId,
      localSentDate: entityObject.localSentDate,
      messageDeliveryState: entityObject.messageDeliveryState,
      remoteCreationDate: entityObject.remoteCreationDate,
      user: entityObject.user,
      remoteMessageId: entityObject.remoteMessageId,
      isLiveMessage: entityObject.isLiveMessage,
      localReceivedDate: entityObject.localReceivedDate,
      receivedImage: entityObject.receivedImage,
    );
  }

  @override
  MessagesCollectionModel toLocalDBModel() {
    final localImageMessage = ImageMessage()
      ..imageFilePath = receivedImage.imageFile?.path
      ..thumbnailFilePath = receivedImage.thumbnailFile?.path
      ..hight = receivedImage.imageMetaData.hight
      ..width = receivedImage.imageMetaData.width
      ..size = receivedImage.imageMetaData.size;

    return super.toLocalDBModel()
      ..messageType = MessageType.image.name
      ..imageMessage = localImageMessage;
  }

  factory ReceivedImageMessageModel.fromRemoteModel(
    RemoteMessageModel remoteModel, {
    required bool isLiveMessage,
  }) {
    final image = Image(
      imageMetaData: const ImageMetaData().fromJson(remoteModel.metaData),
      thumbnailFile: remoteModel.thumbnailFile,
      imageFile: remoteModel.remoteFile,
      imageURL: remoteModel.remoteFileURL,
      thumbnailURL: remoteModel.thumbnailURL,
    );

    return ReceivedImageMessageModel(
      localMessageId: remoteModel.sentDate.microsecondsSinceEpoch,
      remoteMessageId: remoteModel.remoteMessageId,
      user: remoteModel.sender,
      messageDeliveryState: ReceivedMessageDeliveryState.values.byName(
        remoteModel.messageDeliveryState,
      ),
      localSentDate: remoteModel.sentDate,
      remoteCreationDate: remoteModel.remoteCreationDate,
      receivedImage: image,
      isLiveMessage: isLiveMessage,
      localReceivedDate: DateTime.now().toUtc(),
    );
  }

  factory ReceivedImageMessageModel.fromLocalDBModel(
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

    return ReceivedImageMessageModel(
      localMessageId: localModel.localMessageId,
      remoteMessageId: localModel.remoteMessageId,
      user: user,
      remoteCreationDate: localModel.remoteCreationDate,
      messageDeliveryState: ReceivedMessageDeliveryState.values
          .byName(localModel.receivedMessageDeliveryStateForLocalDB.name),
      localSentDate: localModel.localSentDate,
      receivedImage: image,
      isLiveMessage: false,
      localReceivedDate:
          localModel.receivedMessageProperties!.localReceivedDate,
    );
  }
}
