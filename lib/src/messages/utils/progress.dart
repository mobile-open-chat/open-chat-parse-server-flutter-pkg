import 'package:equatable/equatable.dart';

class Progress extends Equatable {
  final int total;
  final int progress;

  const Progress(this.total, this.progress);

  @override
  List<Object?> get props => [
        total,
        progress,
      ];
}
