import '../../../messages/domain/entities/messages_base.dart';

abstract class ProcessManagerBase<R, T extends MessageBase> {
  R startOrAttachToRunningProcess(T message);

  Future<void> disposeAllProcesses();

  Future<void> disposeAllFinishedProcesses();
}
