// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

// TODO see if this can be moved to Harvest

/** Manage life cycle of long running processes */
class ProcessManager {
  @inject
  ProcessManager(this._messageBus) {
    _messageBus.stream(UserCreated).listen(_createUser);
    _messageBus.stream(UserSetupCompleted).listen((e) => removeProcess(e.processId));
  }
  
  _createUser(UserCreated event) {
    var process = new UserSetupProcess(_messageBus, event.userId);
    registerProcess(process);
    process.run();
  }
  
  /** register process for life cycle management */
  registerProcess(Process process) {
    _processes[process.processId] = process;
  }
  
  /** remove process from life cycle */
  removeProcess(Guid processId) {
    if(_processes.containsKey(processId)) {
      _processes.remove(processId);
    } else {
      throw new StateError('unknown process $processId');
    }
  }
  
  final _processes = new Map<Guid, Process>();
  final MessageBus _messageBus;
}