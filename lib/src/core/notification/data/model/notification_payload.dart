import 'package:equatable/equatable.dart';

import '../../../utils/undefined.dart';

class NotificationPayload extends Equatable {
  final String groupID;
  final int notificationID;
  final String title;
  final String messageType;
  final String? bodyText;
  final String? largeIconURL;
  final String? largeIconFilePath;

  const NotificationPayload({
    required this.notificationID,
    required this.groupID,
    required this.title,
    required this.bodyText,
    required this.messageType,
    required this.largeIconURL,
    required this.largeIconFilePath,
  });
  factory NotificationPayload.fromJson(Map<String, dynamic> jsonMap) {
    return NotificationPayload(
      notificationID: int.parse(jsonMap['notificationID'] as String),
      groupID: jsonMap['groupID'] as String,
      title: jsonMap['title'] as String,
      bodyText: jsonMap['bodyText'] as String?,
      messageType: jsonMap['messageType'] as String,
      largeIconURL: jsonMap['largeIconURL'] as String?,
      largeIconFilePath: jsonMap['largeIconFilePath'] as String?,
    );
  }

  NotificationPayload copyWith({
    int? notificationID,
    String? groupID,
    String? title,
    Object? bodyText = undefined,
    String? messageType,
    Object? largeIconURL = undefined,
    Object? largeIconFilePath = undefined,
  }) {
    return NotificationPayload(
      notificationID: notificationID ?? this.notificationID,
      groupID: groupID ?? this.groupID,
      title: title ?? this.title,
      messageType: messageType ?? this.messageType,
      bodyText: isNotPassedParameter(bodyText)
          ? this.bodyText
          : (bodyText as String?),
      largeIconURL: isNotPassedParameter(largeIconURL)
          ? this.largeIconURL
          : (largeIconURL as String?),
      largeIconFilePath: isNotPassedParameter(largeIconFilePath)
          ? this.largeIconFilePath
          : (largeIconFilePath as String?),
    );
  }

  Map<String, String?> toJson() => {
        'notificationID': notificationID.toString(),
        'groupID': groupID,
        'title': title,
        'bodyText': bodyText,
        'messageType': messageType,
        'largeIconURL': largeIconURL,
        'largeIconFilePath': largeIconFilePath,
      };

  @override
  List<Object?> get props => [
        notificationID,
        groupID,
        title,
        bodyText,
        messageType,
        largeIconURL,
        largeIconFilePath
      ];
}
