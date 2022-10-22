import 'package:flutter_parse_chat/src/core/error/failures/failures.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'exception_base.dart';

abstract class ServerException extends ExceptionBase {
  final int? code;
  const ServerException(String message, this.code) : super(message);
  
  @override
  Failure asFailure() {
    return ServerFailure(message, code);
  }
}

class ParseException extends ServerException {
  final String? type;

  const ParseException._(
      {required String message, required int? code, this.type})
      : super(message, code);

  /// [isLogin]: set to true if you are in login screen, because parse
  /// will return (101) error code for both invalid login credentials and object not
  /// found, so we will return [ParseInvalidUsernameOrPassword] if we are in login
  /// screen and [ParseUnknownError] otherwise.
  factory ParseException.extractParseException(
    ParseError? parseError, {
    bool isLogin = false,
  }) {
    if (parseError == null) {
      return ParseUnknownError();
    }
    // custom cloud code errors starts from 1000
    // see [ParseCloudCodeCustomException] docs form more info about the error codes
    if (parseError.code >= 1000) {
      return ParseCloudCodeCustomException.extractCloudCodeException(
        parseError,
      );
    }
    switch (parseError.code) {
      case 209:
        return ParseInvalidSessionToken.fromParseError(parseError);
      case 206:
        return ParseSessionMissing.fromParseError(parseError);
      case 202:
        return ParseUserEmailTaken.fromParseError(parseError);
      case 203:
        return ParseUserEmailTaken.fromParseError(parseError);
      case 150:
        return ParseInvalidImageData.fromParseError(parseError);
      case 125:
        return ParseInvalidEmailAddress.fromParseError(parseError);
      case 101:
        if (isLogin) {
          return ParseInvalidUsernameOrPassword.fromParseError(parseError);
        } else {
          return ParseUnknownError.fromParseError(parseError);
        }
      case -1:
        return ParseUnknownError.fromParseError(parseError);
      case 1:
        return ParseSuccessResponseWithNoResults.fromParseError(parseError);
    }
    return ParseUnknownError.fromParseError(parseError);
  }
  ParseException.fromParseError(ParseError parseError)
      : this._(
          message: parseError.message,
          code: parseError.code,
          type: parseError.type,
        );

  @override
  List<Object?> get props => [...super.props, code, type];
}

class ParseInvalidSessionToken extends ParseException {
  ParseInvalidSessionToken.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

class ParseSessionMissing extends ParseException {
  ParseSessionMissing.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

class ParseUserEmailTaken extends ParseException {
  ParseUserEmailTaken.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

class ParseInvalidImageData extends ParseException {
  ParseInvalidImageData.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

class ParseInvalidEmailAddress extends ParseException {
  ParseInvalidEmailAddress.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

class ParseOperationForbidden extends ParseException {
  ParseOperationForbidden.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

class ParseInvalidUsernameOrPassword extends ParseException {
  ParseInvalidUsernameOrPassword.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

class ParseUnknownError extends ParseException {
  ParseUnknownError()
      : super.fromParseError(
            ParseError(code: 0, message: 'UnknownError, null'));

  ParseUnknownError.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

class ParseSuccessResponseWithNoResults extends ParseException {
  ParseSuccessResponseWithNoResults.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

/// ---------------------------------------------------------------------------
/// |  1000  | Error sending chat message the current user was blocked by the |
///          | other user.                                                    |
/// ---------------------------------------------------------------------------
/// |  1001  | Error while deleting media message in chat                     |
/// ---------------------------------------------------------------------------
class ParseCloudCodeCustomException extends ParseException {
  ParseCloudCodeCustomException.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
  factory ParseCloudCodeCustomException.extractCloudCodeException(
      ParseError parseError) {
    switch (parseError.code) {
      case 1000:
        return ErrorTheCurrentUserWasBlockedByTheOtherUser.fromParseError(
            parseError);

      case 1001:
        return ErrorWhileDeletingMediaMessageFromChat.fromParseError(
          parseError,
        );
    }
    return ParseCloudCodeCustomException.fromParseError(parseError);
  }
}

abstract class ChatRelatedCloudCodeException
    extends ParseCloudCodeCustomException {
  ChatRelatedCloudCodeException.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}

class ErrorTheCurrentUserWasBlockedByTheOtherUser
    extends ChatRelatedCloudCodeException {
  ErrorTheCurrentUserWasBlockedByTheOtherUser.fromParseError(
      ParseError parseError)
      : super.fromParseError(parseError);
}

class ErrorWhileDeletingMediaMessageFromChat
    extends ChatRelatedCloudCodeException {
  ErrorWhileDeletingMediaMessageFromChat.fromParseError(ParseError parseError)
      : super.fromParseError(parseError);
}
