import '../../../error/failures/failures.dart';
import '../../../utils/either.dart';
import '../../domain/entities/current_user.dart';

abstract class UserRepository {
  Future<Either<NoUserLoggedFailure, CurrentUser>> getCurrentUser();

  Future<Either<Failure, CurrentUser>> getUpdatedCurrentUser();
}
