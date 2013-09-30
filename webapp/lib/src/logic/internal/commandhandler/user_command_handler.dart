// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

class UserCommandHandler {
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
    currentUser.addNoteToNotebook(note:command.noteId, notebook:command.notebookId);
    _userRepository.save(currentUser).then((_) => command.completeSuccess());
  }
  
  _createNotebook(CreateNotebook command) {
    var notebookId = command.notebookId != null ? command.notebookId : new Guid();
    currentUser.createNotebook(command.notebookName, notebookId);
    _userRepository.save(currentUser).then((_) => command.completeSuccess());
  }
  
  _createUser(CreateUser command) {
    // TODO this is bad, find a better way to setup the current user
    currentUser = new User(command.username);
    _userRepository.save(currentUser).then((_) => command.completeSuccess());
  }
  
  // TODO if we do this then we must run each session in its own isolate on the server
  // TODO figure out if there are any thread locals like constructs we can use ?
  User currentUser;

  final MessageBus _messageBus;
  final DomainRepository<User> _userRepository;
}