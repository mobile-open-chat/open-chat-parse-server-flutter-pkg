abstract class Either<L, R> {
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);

  bool isLeft();
  bool isRight();

  Left<L, R> getLeft();
  Right<L, R> getRight();

  L getLeftValue();
  R getRightValue();
}

class Left<L, R> extends Either<L, R> {
  final L left;

  Left(this.left);

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(left);

  @override
  bool isLeft() => true;

  @override
  bool isRight() => false;

  @override
  Left<L, R> getLeft() => this;

  @override
  Right<L, R> getRight() => throw NotRightException();

  @override
  L getLeftValue() => left;

  @override
  R getRightValue() => throw NotRightException();
}

class Right<L, R> extends Either<L, R> {
  final R right;

  Right(this.right);

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(right);

  @override
  bool isLeft() => false;

  @override
  bool isRight() => true;

  @override
  Left<L, R> getLeft() => throw NotLeftException();

  @override
  Right<L, R> getRight() => this;

  @override
  L getLeftValue() => throw NotLeftException();

  @override
  R getRightValue() => right;
}

class NotRightException implements Exception {}

class NotLeftException implements Exception {}
