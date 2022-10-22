import 'package:equatable/equatable.dart';
import '../failures/failures.dart';

abstract class ExceptionBase extends Equatable implements Exception {
  final String message;

  const ExceptionBase(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];

  Failure asFailure();
}
