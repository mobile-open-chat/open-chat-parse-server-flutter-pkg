import 'package:flutter/foundation.dart' show protected;

abstract class ProcessManagerBase<R, T> {
  R startOrAttachToRunningProcess(T message);

  Future<void> disposeAllProcesses();

  @protected
  Future<void> disposeProcess(int processId);

  Future<void> disposeAllFinishedProcesses();
}
