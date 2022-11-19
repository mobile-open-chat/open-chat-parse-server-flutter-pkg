import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;
import 'package:rxdart/rxdart.dart';

import '../../../../core/error/exceptions/server_exception.dart';
import '../../../../core/error/exceptions/user_exception.dart';
import '../../../../core/user/data/models/custom_parse_user.dart';
import '../../../domain/entities/connection_state.dart';
import '../../../domain/entities/message_type.dart';
import 'models/remote_message_model.dart';

abstract class MessagesRemoteDataSource {
  const MessagesRemoteDataSource();

  Future<RemoteMessageModel> sendTextMessage(RemoteMessageModel message);

  Future<String> uploadFile(
    File file,
    void Function(int progress, int total) progressCallback,
  );

  Future<File> downloadFile(
    String url,
    void Function(int progress, int total) progressCallback,
  );

  Future<RemoteMessageModel> sendImageMessage(RemoteMessageModel message);

  ValueStream<ConnectionState> connectionStateStream();

  Stream<RemoteMessageModel> listenForNewMessages();

  Future<List<RemoteMessageModel>> pullMissedMessages(
    DateTime? lastReceivedMessageDate,
  );

  Future<void> dispose();
}

class MessagesRemoteDataSourceImpl extends MessagesRemoteDataSource {
  @override
  Future<RemoteMessageModel> sendTextMessage(RemoteMessageModel message) async {
    assert(message.textMessage != null);
    assert(message.receivedMessageType == MessageType.text.name);

    return _sendMessage(
      message,
      'Can not sent text message, connection exception',
    );
  }

  @override
  Future<RemoteMessageModel> sendImageMessage(RemoteMessageModel message) {
    assert(message.remoteFile != null && message.remoteFileURL != null);
    assert(message.receivedMessageType == MessageType.image.name);

    return _sendMessage(
      message,
      'Can not sent image message, connection exception',
    );
  }

  @override
  Future<String> uploadFile(
    File file,
    void Function(int progress, int total) progressCallback,
  ) async {
    final parseFile = ParseFile(file);

    final ParseResponse uploadFileResponse;
    try {
      uploadFileResponse = await parseFile.upload(
        progressCallback: progressCallback,
      );
    } catch (error) {
      throw InternetConnectionException(
        "Can't upload the file connection error \nError:$error",
      );
    }
    if (!uploadFileResponse.success) {
      throw ParseException.extractParseException(uploadFileResponse.error);
    }

    return parseFile.url!;
  }

  Future<RemoteMessageModel> _sendMessage(
    RemoteMessageModel message,
    String internetConnectionErrorMessage,
  ) async {
    final ParseResponse sendMessageResponse;

    try {
      sendMessageResponse = await message.create();
    } catch (error) {
      throw InternetConnectionException(
        '$internetConnectionErrorMessage\nError:$error',
      );
    }
    if (sendMessageResponse.success &&
        sendMessageResponse.results != null &&
        sendMessageResponse.count != 0) {
      return sendMessageResponse.results!.first as RemoteMessageModel;
    } else {
      throw ParseException.extractParseException(sendMessageResponse.error);
    }
  }

  @override
  Future<File> downloadFile(
    String url,
    void Function(int progress, int total) progressCallback,
  ) async {
    var parseFile = ParseFile(
      null,
      url: url,
      name: path.basename(url),
    );

    try {
      parseFile = await parseFile.download(
        progressCallback: progressCallback,
      );

      return parseFile.file!;
    } catch (error) {
      throw InternetConnectionException(
        "Can't download the file connection error \nError:$error",
      );
    }
  }

  late final StreamController<RemoteMessageModel>
      _liveMessagesStreamController = StreamController();
  late final LiveQuery _messagesLiveQuery = LiveQuery();
  late StreamSubscription? _liveQueryConnectionStateStreamSubscription;

  @override
  Stream<RemoteMessageModel> listenForNewMessages() async* {
    final messagesQueryBuilder = QueryBuilder<RemoteMessageModel>.name(
      RemoteMessageModel.keyClassName,
    )..whereGreaterThan(
        RemoteMessageModel.keyRemoteCreationDate,
        DateTime.now().toUtc(),
      );

    final subscription = await _messagesLiveQuery.client
        .subscribe<RemoteMessageModel>(messagesQueryBuilder);

    subscription.on(LiveQueryEvent.create, (RemoteMessageModel newMessage) {
      _liveMessagesStreamController.sink.add(newMessage);
    });

    _liveQueryConnectionStateStreamSubscription =
        _messagesLiveQuery.client.getClientEventStream.listen((event) {
      if (event == LiveQueryClientEvent.CONNECTED) {
        _dispatchConnected();
      } else {
        _dispatchConnecting();
      }
    });

    yield* _liveMessagesStreamController.stream;
  }

  @override
  Future<List<RemoteMessageModel>> pullMissedMessages(
    DateTime? lastReceivedMessageDate,
  ) async {
    var retryInterval = const Duration(seconds: 2);

    if (lastReceivedMessageDate == null) {
      return _callCloudFunctionToInitTheClient();
    }

    final messagesQueryBuilder =
        QueryBuilder<RemoteMessageModel>.name(RemoteMessageModel.keyClassName)
          ..includeObject([
            RemoteMessageModel.keySender,
            RemoteMessageModel.keyReceiver,
          ])
          ..whereGreaterThan(
            RemoteMessageModel.keyRemoteCreationDate,
            lastReceivedMessageDate,
          );

    List<RemoteMessageModel> messagesResult;
    do {
      _dispatchUpdating();
      try {
        messagesResult = await messagesQueryBuilder.find();
      } catch (error) {
        _dispatchConnecting();
        if (ParseCoreData().debug) {
          log(
            'pullMissedMessages error retrying after ${retryInterval.inSeconds} seconds...',
            error: error.toString(),
          );
        }

        await Future.delayed(retryInterval *= 2);
        continue;
      }
      _dispatchUpdated();
      return messagesResult;
    } while (true);
  }

  Future<List<RemoteMessageModel>> _callCloudFunctionToInitTheClient() async {
    var retryInterval = const Duration(seconds: 2);

    final cloudFunction = ParseCloudFunction('intiClientChatMessages');
    ParseResponse cloudResponse;
    do {
      _dispatchUpdating();
      try {
        cloudResponse = await cloudFunction.execute();
      } catch (error) {
        _dispatchConnecting();
        if (ParseCoreData().debug) {
          log(
            'pullMissedMessages from cloud error retrying after ${retryInterval.inSeconds} seconds...',
            error: error.toString(),
          );
        }

        await Future.delayed(retryInterval *= 2);
        continue;
      }
      if (!cloudResponse.success || cloudResponse.error != null) {
        _dispatchConnecting();
        if (ParseCoreData().debug) {
          log(
            'pullMissedMessages from cloud error retrying after ${retryInterval.inSeconds} seconds...',
            error: cloudResponse.error.toString(),
          );
        }
        await Future.delayed(retryInterval *= 2);
        continue;
      }

      _dispatchUpdated();

      return extractChatWithMessagesFromPayload(
        cloudResponse.result as String?,
      );
    } while (true);
  }

  List<RemoteMessageModel> extractChatWithMessagesFromPayload(String? payload) {
    if (payload == null) {
      return [];
    }

    final messages = <RemoteMessageModel>[];
    final List<Map<String, dynamic>> payloadMap;
    try {
      payloadMap = List<Map<String, dynamic>>.from(
        (jsonDecode(payload) as Map<String, dynamic>)["result"] as Iterable,
      );
    } catch (error) {
      return [];
    }

    for (final chatUserWithMessages in payloadMap) {
      messages.addAll(
        extractChatMessages(chatUserWithMessages),
      );
    }
    return messages;
  }

  List<RemoteMessageModel> extractChatMessages(
    Map<String, dynamic> chatUserWithMessages,
  ) {
    final chatMessages = <RemoteMessageModel>[];
    final chatUser = extractParseUserFromJson(chatUserWithMessages);

    for (final userMessage in chatUserWithMessages["messages"]) {
      final message = RemoteMessageModel()
          .fromJson(userMessage as Map<String, dynamic>) as RemoteMessageModel;

      /// Because the message hold a [sender] and [receiver] of type Pointer
      /// we can't access the actual data of the objects.
      /// And we are interested in the other user data (name, profileImage, etc...)
      /// so if the sender is the other user then:
      ///   set the sender object to [chatUser]
      /// otherwise:
      ///   set the receiver object to [chatUser]
      ///
      /// The [chatUser] is a compleat object and its not a pointer.
      if (_isChatUserTheSenderOfThisMessage(message, chatUser)) {
        message.set(RemoteMessageModel.keySender, chatUser);
      } else {
        message.set(RemoteMessageModel.keyReceiver, chatUser);
      }

      chatMessages.add(message);
    }

    return chatMessages;
  }

  bool _isChatUserTheSenderOfThisMessage(
    RemoteMessageModel message,
    CustomParseUser chatUser,
  ) {
    return message.sender.userId == chatUser.userId;
  }

  CustomParseUser extractParseUserFromJson(
    Map<String, dynamic> chatUserMessages,
  ) {
    final chatUser = CustomParseUser(
      chatUserMessages[keyVarUsername] as String,
      null,
      null,
    )
      ..set(CustomParseUser.keyName, chatUserMessages[CustomParseUser.keyName])
      ..set(keyVarObjectId, chatUserMessages[keyVarObjectId])
      ..set(
        keyVarCreatedAt,
        DateTime.parse(chatUserMessages[keyVarCreatedAt] as String),
      )
      ..set(
        keyVarUpdatedAt,
        DateTime.parse(chatUserMessages[keyVarUpdatedAt] as String),
      )
      ..set(
        keyVarAcl,
        ParseACL()
            .fromJson(chatUserMessages[keyVarAcl] as Map<String, dynamic>),
      );

    final profileImage = chatUserMessages[CustomParseUser.keyProfileImage]
        as Map<String, dynamic>?;

    if (profileImage != null) {
      chatUser.set(
        CustomParseUser.keyProfileImage,
        ParseFile(
          null,
          name: profileImage['name'] as String?,
          url: profileImage['url'] as String?,
        ),
      );
    }

    return chatUser;
  }

  late final BehaviorSubject<ConnectionState> _connectionStateBehaviorSubject =
      BehaviorSubject<ConnectionState>();

  @override
  ValueStream<ConnectionState> connectionStateStream() {
    return _connectionStateBehaviorSubject.stream;
  }

  void _dispatchConnected() {
    _dispatchConnectionState(ConnectionState.connected);
  }

  void _dispatchConnecting() {
    _dispatchConnectionState(ConnectionState.connecting);
  }

  void _dispatchUpdating() {
    _dispatchConnectionState(ConnectionState.updating);
  }

  void _dispatchUpdated() {
    _dispatchConnectionState(ConnectionState.updated);
  }

  void _dispatchConnectionState(ConnectionState connectionState) {
    if (_connectionStateBehaviorSubject.isClosed) {
      return;
    }
    _connectionStateBehaviorSubject.sink.add(connectionState);
  }

  @override
  Future<void> dispose() async {
    await _liveQueryConnectionStateStreamSubscription?.cancel();
    await _messagesLiveQuery.client.disconnect(userInitialized: true);
    await _liveMessagesStreamController.close();
    await _connectionStateBehaviorSubject.close();
  }
}
