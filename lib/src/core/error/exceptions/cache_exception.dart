import '../failures/failures.dart';

import 'exception_base.dart';

class CacheException extends ExceptionBase {
  const CacheException(super.message);

  @override
  Failure asFailure() {
    return CacheFailure(message);
  }
}
