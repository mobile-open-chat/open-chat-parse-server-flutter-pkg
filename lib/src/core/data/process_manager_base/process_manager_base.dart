import 'package:flutter/foundation.dart' show protected;

import '../../../messages/domain/entities/messages_base.dart';

abstract class ProcessManagerBase<R, T extends MessageBase> {
  R startOrAttachToRunningProcess(T message);

  Future<void> disposeAllProcesses();

  @protected
  Future<void> disposeProcess(int processId);

  Future<void> disposeAllFinishedProcesses();
}
