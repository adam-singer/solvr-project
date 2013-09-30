// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

library solvr_logic;

import 'package:dice/dice.dart';

import 'logic/solvr_logic_api.dart';
export 'logic/solvr_logic_api.dart';
import 'logic/solvr_logic_internal.dart';

// TODO get rid of this when dart:mirrors get sync API
class LogicConfig {
  @Inject
  LogicConfig(this.messageBus, this.viewModelRepository, EventStore eventStore) {
    var eventHandler = new EventHandler(messageBus, viewModelRepository);
    var userCommandHandler = new UserCommandHandler(messageBus, eventStore);
    var noteCommandHandler = new NoteCommandHandler(messageBus, eventStore);
    var processManager = new ProcessManager(messageBus);
  }
  
  final MessageBus messageBus;
  final ViewModelRepository viewModelRepository;
}

class MockDependenciesModule extends Module {
  configure() {
    bind(EventStore).toInstance(new MemoryEventStore());
    bind(MessageBus).toInstance(new MessageBus());
    bind(ViewModelRepository).toInstance(new ViewModelRepositoryImpl());
  }
}