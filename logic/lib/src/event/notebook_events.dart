// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class NotebookCreated extends DomainEvent {
  NotebookCreated(this.notebookId, this.notebookName);
  
  final String notebookName;
  final Guid notebookId;
}

class NotebookDeleted extends DomainEvent {
  NotebookDeleted(this.notebookId);
  
  // TODO add time
  final Guid notebookId;
}

class NotebookRenamed extends DomainEvent  {
  NotebookRenamed(this.notebookId, this.notebookName, this.userId);
  
  final String notebookName;
  final Guid notebookId;
  final Guid userId;
}

class NoteAddedToNotebook extends DomainEvent {
  NoteAddedToNotebook(this.noteId, this.targetId);
  
  // TODO add time
  final Guid noteId, targetId;
}

class NoteRemovedFromNotebook extends DomainEvent {
  NoteRemovedFromNotebook(this.noteId, this.targetId);
  
  // TODO add time
  final Guid noteId, targetId;
}
