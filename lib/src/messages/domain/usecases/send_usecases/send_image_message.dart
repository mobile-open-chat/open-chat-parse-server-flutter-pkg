import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart' as flutter_painting
    show decodeImageFromList;

import '../../../../core/usecases/usecase.dart';
import '../../../../core/user/domain/entities/user.dart';
import '../../../../core/utils/either.dart';
import '../../../utils/chat_typedef.dart';
import '../../entities/image_message/image.dart';
import '../../entities/image_message/sent_image_message.dart';
import '../../entities/sent_message_base.dart';
import '../../repositories/messages_repository.dart';

class SendImageMessage
    implements
        UseCase<SendImageMessageParams, StreamOfProgressOrSentImageMessage> {
  final MessagesRepository _messagesRepository;

  SendImageMessage(this._messagesRepository);

  @override
  StreamOfProgressOrSentImageMessage call(
    SendImageMessageParams params,
  ) async* {
    final dateTime = DateTime.now().toUtc();

    var message = SentImageMessage(
      localMessageId: -1,
      localSentDate: dateTime,
      user: params.receiver,
      messageDeliveryState: SentMessageDeliveryState.pending,
      sentImage: params.image,
      remoteMessageId: null,
      remoteCreationDate: null,
    );

    if (params.localMessageId == null) {
      final imageMetaData = await _generateImageMetaData(
        params.image.imageFile!,
      );

      final image = params.image.copyWith(imageMetaData: imageMetaData);

      message = message.copyWith(
        localMessageId: dateTime.microsecondsSinceEpoch,
        sentImage: image,
      );

      // So the user can see the image while its sending
      yield* Stream.value(Right(message));

      yield* _messagesRepository.sendImageMessage(message);
    } else {
      message = message.copyWith(
        localMessageId: params.localMessageId,
      );
      yield* _messagesRepository.sendImageMessage(message);
    }
  }
}

class SendImageMessageParams extends Equatable {
  final Image image;
  final User receiver;
  final int? localMessageId;

  SendImageMessageParams({
    required this.image,
    required this.receiver,
    required this.localMessageId,
  }) : assert(image.imageFile != null);

  @override
  List<Object?> get props => [
        image,
        receiver,
        localMessageId,
      ];
}

Future<ImageMetaData> _generateImageMetaData(
  File imageFile,
) async {
  try {
    final imageBytes = await imageFile.readAsBytes();
    final decodedImage = await flutter_painting.decodeImageFromList(imageBytes);
    return ImageMetaData(
      hight: decodedImage.height,
      width: decodedImage.width,
      size: imageBytes.lengthInBytes,
    );
  } catch (error) {
    return const ImageMetaData();
  }
}
