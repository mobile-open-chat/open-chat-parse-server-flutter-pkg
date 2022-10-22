import 'package:equatable/equatable.dart';

abstract class UseCase<Params, R> {
  R call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
