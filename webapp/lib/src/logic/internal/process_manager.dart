// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

/** Manage life cycle of long running processes */
class ProcessManager {
  ProcessManager(this._messageBus) {
    _messageBus.stream(UserCreated).listen(_createUser);
    _messageBus.stream(UserSetupCompleted).listen((e) => _disposeProcess(e.processId));
  }
  
  _createUser(UserCreated event) {
    var process = new UserSetupProcess(_messageBus, event.userId);
    _processes[process.processId] = process;
    process.run();
  }
  
  _disposeProcess(Guid processId) {
    if(_processes.containsKey(processId)) {
      _processes.remove(processId);
    } else {
      throw new StateError('unknown long running process $processId finished');
    }
  }
  
  final _processes = new Map<Guid, Object>();
  final MessageBus _messageBus;
}