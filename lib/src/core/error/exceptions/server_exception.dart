import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../failures/failures.dart';
import 'exception_base.dart';

abstract class ServerException extends ExceptionBase {
  final int? code;
  const ServerException(super.message, this.code);

  @override
  Failure asFailure() {
    return ServerFailure(message, code);
  }
}

class ParseException extends ServerException {
  final String? type;

  const ParseException._({
    required String message,
    required int? code,
    this.type,
  }) : super(message, code);

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
  ParseInvalidSessionToken.fromParseError(super.parseError)
      : super.fromParseError();
}

class ParseSessionMissing extends ParseException {
  ParseSessionMissing.fromParseError(super.parseError) : super.fromParseError();
}

class ParseUserEmailTaken extends ParseException {
  ParseUserEmailTaken.fromParseError(super.parseError) : super.fromParseError();
}

class ParseInvalidImageData extends ParseException {
  ParseInvalidImageData.fromParseError(super.parseError)
      : super.fromParseError();
}

class ParseInvalidEmailAddress extends ParseException {
  ParseInvalidEmailAddress.fromParseError(super.parseError)
      : super.fromParseError();
}

class ParseOperationForbidden extends ParseException {
  ParseOperationForbidden.fromParseError(super.parseError)
      : super.fromParseError();
}

class ParseInvalidUsernameOrPassword extends ParseException {
  ParseInvalidUsernameOrPassword.fromParseError(super.parseError)
      : super.fromParseError();
}

class ParseUnknownError extends ParseException {
  ParseUnknownError()
      : super.fromParseError(
          ParseError(code: 0, message: 'UnknownError, null'),
        );

  ParseUnknownError.fromParseError(super.parseError) : super.fromParseError();
}

class ParseSuccessResponseWithNoResults extends ParseException {
  ParseSuccessResponseWithNoResults.fromParseError(super.parseError)
      : super.fromParseError();
}

/// ---------------------------------------------------------------------------
/// |  1000  | Error sending chat message the current user was blocked by the |
///          | other user.                                                    |
/// ---------------------------------------------------------------------------
/// |  1001  | Error while deleting media message in chat                     |
/// ---------------------------------------------------------------------------
class ParseCloudCodeCustomException extends ParseException {
  ParseCloudCodeCustomException.fromParseError(super.parseError)
      : super.fromParseError();
  factory ParseCloudCodeCustomException.extractCloudCodeException(
    ParseError parseError,
  ) {
    switch (parseError.code) {
      case 1000:
        return ErrorTheCurrentUserWasBlockedByTheOtherUser.fromParseError(
          parseError,
        );

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
  ChatRelatedCloudCodeException.fromParseError(super.parseError)
      : super.fromParseError();
}

class ErrorTheCurrentUserWasBlockedByTheOtherUser
    extends ChatRelatedCloudCodeException {
  ErrorTheCurrentUserWasBlockedByTheOtherUser.fromParseError(
      super.parseError,)
      : super.fromParseError();
}

class ErrorWhileDeletingMediaMessageFromChat
    extends ChatRelatedCloudCodeException {
  ErrorWhileDeletingMediaMessageFromChat.fromParseError(super.parseError)
      : super.fromParseError();
}
