// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

/** User */
class User extends AggregateRoot {  
  factory User(String name) {
    var userId = new Guid();
    var user = new User.fromId(userId);
    user._recordEvent(new UserCreated(name, userId));
    return user;
  }
  
  User.fromId(Guid userId): super(userId);
  
  apply(DomainEvent event) {
    if(event is UserEvent) {
      if(event is UserCreated) {
        _applyUserCreated(event);        
      }
      // enforce access control after creation
      _checkUserAccess(event);
    }
    
    if(event is NotebookEvent) {
      if(event is NotebookCreated) {
        _applyNotebookCreated(event);
      } 
      // enforce access control after creation
      _checkNotebookAccess(event);
      
      if(event is NoteAddedToNotebook) {
        _applyNoteAddedToNotebook(event);
      }
    }
  }
  
  addNoteToNotebook({Guid note, Guid notebook}) => _recordUserEvent(new NoteAddedToNotebook(noteId:note, notebookId:notebook));
  
  createNotebook(String name, Guid notebookId) => _recordUserEvent(new NotebookCreated(name, notebookId));
  
  _applyUserCreated(UserCreated event) {
    _name = event.username;
  }
  
  _applyNotebookCreated(NotebookCreated event) {
    event = event as NotebookCreated;
    if(_notebooks.contains(event.notebookId)) {
      throw new StateError("notebook with id ${event.notebookId} already exists");
    }
    _notebooks.add(event.notebookId);
  }
  
  _applyNoteAddedToNotebook(NoteAddedToNotebook event) {
    event = event as NoteAddedToNotebook;
    if(_notes.containsKey(event.noteId)) {
      throw new StateError("note with id ${event.noteId} already exists");
    }
    _notes[event.noteId] = event.notebookId;
  }
  
  _checkNotebookAccess(NotebookEvent event) {
    if(!_notebooks.contains(event.notebookId)) {
      throw new StateError("cannot apply $event to unknown notebook ${event.notebookId}");
    }
  }
  
  _checkUserAccess(UserEvent event) {
    if(this.id != event.userId) {
      throw new StateError("cannot apply user event $event to user with id ${this.id}");
    }
  }
  
  _recordUserEvent(UserEvent event) {
    event.userId = id;
    applyChange(event);
  }
  
  String _name;
  final _notebooks = new Set<Guid>();
  final _notes = new Map<Guid, Guid>();
}

