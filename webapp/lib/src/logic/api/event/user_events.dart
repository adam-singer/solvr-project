// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_api;

class NotebookCreated extends NotebookEvent {
  NotebookCreated(this.notebookName, Guid notebookId): super(notebookId);
  
  final String notebookName;
}

class NoteAddedToNotebook extends NotebookEvent {
  NoteAddedToNotebook({this.noteId, Guid notebookId}): super(notebookId);
  
  final Guid noteId;
}

abstract class NotebookEvent extends UserEvent {
  NotebookEvent(this.notebookId);
  
  final Guid notebookId;
}

class UserCreated extends UserEvent {
  UserCreated(this.username, Guid userId) {
    this.userId = userId;
  }
  
  final String username;
}

abstract class UserEvent extends DomainEvent {
  Guid userId;
}