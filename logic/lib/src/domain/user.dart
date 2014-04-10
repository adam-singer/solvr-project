// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

/**
 * A user in the system
 */
class User extends AggregateRoot {
  factory User(String name, String email) {
    var userId = new Guid();
    var user = new User.fromId(userId);
    applyChange(new UserCreated(new Guid(), name, email)); 
    user._settings = new Settings.defaults(user);
    return user;
  }
  
  User.fromId(Guid userId): super(userId) {
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
