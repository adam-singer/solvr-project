// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

class UserCommandHandler {
  @inject
  factory UserCommandHandler(MessageBus messageBus, EventStore eventStore) {
    var userRepository = new DomainRepository<User>((id) => new User.fromId(id), eventStore, messageBus);
    return new UserCommandHandler._internal(messageBus, userRepository);
  }
  
  UserCommandHandler._internal(this._messageBus, this._userRepository) {
    _messageBus.stream(AddNoteToNotebook).listen(_addNoteToNotebook);
    _messageBus.stream(CreateUser).listen(_createUser);
    _messageBus.stream(CreateNotebook).listen(_createNotebook);
  }
  
  _addNoteToNotebook(AddNoteToNotebook command) {
    var user = _getUserFor(command);
    user.addNoteToNotebook(note:command.noteId, notebook:command.notebookId);
    
    _userRepository.save(user).then((_) => command.completeSuccess());
  }
  
  _createNotebook(CreateNotebook command) {
    var notebookId = command.notebookId != null ? command.notebookId : new Guid();
    var user = _getUserFor(command);
    user.createNotebook(command.notebookName, notebookId);
    
    _userRepository.save(user).then((_) => command.completeSuccess());
  }
  
  _createUser(CreateUser command) {
    var user = new User(command.username);
    _userRepository.save(user).then((_) => command.completeSuccess());
  }
  
  User _getUserFor(DomainCommand command) {
    // TODO use headers to 
  }
  
  final MessageBus _messageBus;
  final DomainRepository<User> _userRepository;
}