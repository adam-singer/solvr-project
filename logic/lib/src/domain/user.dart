// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

/**
 * A user in the system
 */
class User extends AggregateRoot {
  User(String name, String email) {
    applyChange(new UserCreated(new Guid(), name, email)); 
    _settings = new Settings.defaults(this);
  }
  
  User.fromId(Guid userId) {
    id = userId;
    _settings = new Settings(this);
  }
  
  apply(var event) {
    if(event is UserCreated) {
      _name = event.name;
      _email = event.email;
      if(id == null) {
        id = event.userId;
      }
      assertEquals(id, event.userId);
    }
  }
  
  String get email => _email;
  
  String get name => _name;
  
  Settings get settings => _settings;
  
  String _name, _email;
  Settings _settings;
}
