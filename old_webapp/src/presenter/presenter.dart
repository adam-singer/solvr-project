// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web;

abstract class Presenter {
  // TODO singleton message bus (perhaps move to session context)
  Presenter(): messageBus = new MessageBus(); 
  
  User get currentUser => SessionContext.currentUser;
  
  final MessageBus messageBus;
}

abstract class View {
  set presenter(Presenter presenter);
}


