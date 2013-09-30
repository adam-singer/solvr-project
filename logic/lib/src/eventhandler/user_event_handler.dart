// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class UserEventHandler extends EventHandler {
  UserEventHandler() {
    messageBus.sink(UserCreated).add(_onUserCreated);
  }
  
  _onUserCreated(UserCreated event) {
    // create a initial notebook
    // TODO make special event for initial notebook or else fill it with special content
    messageBus.fire(new CreateNote());
  }
}
