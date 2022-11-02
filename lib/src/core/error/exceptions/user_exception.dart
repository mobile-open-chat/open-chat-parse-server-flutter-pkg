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

class NoUserLoggedException extends UserException {
  const NoUserLoggedException(super.message);

  @override
  Failure asFailure() {
    return NoUserLoggedFailure(message);
  }
}

class ErrorWhileSavingTheFile extends UserException {
  const ErrorWhileSavingTheFile(super.message);

  @override
  Failure asFailure() {
    return FileSaveFailure(message);
  }
}
