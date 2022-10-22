import 'package:equatable/equatable.dart';
import 'package:flutter_parse_chat/src/core/error/failures/failures.dart';

abstract class ExceptionBase extends Equatable implements Exception {
  final String message;

  const ExceptionBase(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];

  Failure asFailure();
}
