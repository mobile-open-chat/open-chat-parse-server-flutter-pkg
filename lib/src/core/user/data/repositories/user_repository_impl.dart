import '../../../error/exceptions/exception_base.dart';
import '../../../error/exceptions/user_exception.dart';
import '../../../error/failures/failures.dart';
import '../../../utils/either.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/user_local_data_source.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../models/custom_parse_user.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  UserRepositoryImpl(this._userRemoteDataSource, this._userLocalDataSource);

  @override
  Future<Either<NoUserLoggedFailure, CurrentUser>> getCurrentUser() async {
    final CustomParseUser currentUserModel;
    try {
      currentUserModel = await _userLocalDataSource.getCurrentUser();
    } on NoUserLoggedException catch (error) {
      return Left(error.asFailure() as NoUserLoggedFailure);
    }

    return Right(currentUserModel.toCurrentUserEntityObject());
  }

  @override
  Future<Either<Failure, CurrentUser>> getUpdatedCurrentUser() async {
    CustomParseUser currentUserModel;
    try {
      currentUserModel = await _userLocalDataSource.getCurrentUser();
    } on NoUserLoggedException catch (error) {
      return Left(error.asFailure() as NoUserLoggedFailure);
    }

    try {
      currentUserModel = await _userRemoteDataSource
          .getUpdatedUserFromServer(currentUserModel);
    } on ExceptionBase catch (error) {
      return Left(error.asFailure());
    }

    return Right(currentUserModel.toCurrentUserEntityObject());
  }
}

extension _ToCurrentUser on CustomParseUser {
  CurrentUser toCurrentUserEntityObject() {
    return CurrentUser(
      userId: userId,
      name: name,
      blockedUsersIDs: getListOfBlockedUsers(),
      profileImageFile: profileImageFile,
      profileImageURL: profileImageURL,
    );
  }
}
