import '../failures/failures.dart';

import 'exception_base.dart';

class InternetConnectionException extends ExceptionBase {
  const InternetConnectionException(super.message);

  @override
  Failure asFailure() {
    return InternetConnectionFailure(message);
  }
}

abstract class UserException extends ExceptionBase {
  const UserException(super.message);
}

class NoUserFoundException extends UserException {
  const NoUserFoundException(super.message);

  @override
  Failure asFailure() {
    return UserFailure(message);
  }
}

class ErrorWhileSavingTheFile extends UserException {
  const ErrorWhileSavingTheFile(super.message);

  @override
  Failure asFailure() {
    return FileSaveFailure(message);
  }
}
