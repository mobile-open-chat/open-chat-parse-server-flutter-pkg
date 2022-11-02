abstract class Failure {
  final dynamic message;

  const Failure([this.message]);

  @override
  String toString() {
    return 'message: $message \n ${super.toString()}';
  }
}

class InternetConnectionFailure extends Failure {
  const InternetConnectionFailure([super.message]);
}

class ServerFailure extends Failure {
  final int? code;
  const ServerFailure([
    super.message,
    this.code,
  ]);

  @override
  String toString() {
    return 'code: ${code ?? '_'}\nmessage: $message \n ${super.toString()}';
  }
}

class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

class FileSaveFailure extends CacheFailure {
  const FileSaveFailure([super.message]);
}

class UserFailure extends Failure {
  const UserFailure([super.message]);
}

class NoUserLoggedFailure extends UserFailure {
  const NoUserLoggedFailure([super.message]);
}
