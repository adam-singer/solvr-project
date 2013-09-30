// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class UserCommandHandler extends CommandHandler {
  UserCommandHandler(this._userRepository) {
    messageBus.sink(CreateUser).add(_onCreateUser);
  }
  
  _onCreateUser(CreateUser command) {
    inContext(command, _logger, () {
      if(SessionContext.currentUser != null) {
        // TODO throw a SolvError
        throw new StateError();
      }
      User user = new User(command.name, command.email);
      SessionContext.currentUser = user;
      
      _logger.info("creating user [${user.name}]");
      _userRepository.save(user);
    });
  } 
  
  final DomainRepository<User> _userRepository;
  static final _logger = LoggerFactory.getLoggerFor(UserCommandHandler);
}
