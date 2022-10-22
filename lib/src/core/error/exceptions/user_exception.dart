import 'package:flutter_parse_chat/src/core/error/failures/failures.dart';

import 'exception_base.dart';

class InternetConnectionException extends ExceptionBase {
  const InternetConnectionException(String message) : super(message);

  @override
  Failure asFailure() {
    return InternetConnectionFailure(message);
  }
}

abstract class UserException extends ExceptionBase {
  const UserException(String message) : super(message);
}

class NoUserFoundException extends UserException {
  const NoUserFoundException(super.message);

  @override
  Failure asFailure() {
    return UserFailure(message);
  }
}
