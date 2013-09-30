// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class NoteCreated extends DomainEvent {
  NoteCreated(this.noteId, this.noteName, this.userId, this.username, this.createdAtUtc);
  
  final Guid noteId, userId;
  final String username, noteName;
  final DateTime createdAtUtc;
}

class NoteDeleted extends DomainEvent {
  NoteDeleted(this.notebookId, this.notebookName, this.userId, this.username, this.deletedAtUtc);
  
  final String notebookName, username;
  final Guid notebookId, userId;
  final DateTime deletedAtUtc;
}

class NoteRenamed extends NoteUpdated {
  NoteRenamed(Guid noteId, this.oldName, this.newName, this.userId, this.username, DateTime utcTime): super(noteId, utcTime);
  
  final String oldName, newName, username;
  final Guid userId;
}

class EntryAdded extends NoteUpdated {
  EntryAdded(Guid noteId, this.entryId, this.value, DateTime utcTime): super(noteId, utcTime);
  
  final Guid entryId;
  final String value;
}

class EntryUpdated extends NoteUpdated {
  EntryUpdated(Guid noteId, this.entryId, this.value, this.result, DateTime utcTime): super(noteId, utcTime);
  
  final Guid entryId;
  final String value, result;
}

class EntryDeleted extends NoteUpdated {
  EntryDeleted(Guid noteId, this.entryId, DateTime utcTime): super(noteId, utcTime);
  
  final Guid entryId;
}

// base for all classes that updates content in the note
// TODO make into a mixin
abstract class NoteUpdated extends DomainEvent {
  NoteUpdated(this.noteId, this.updatedAtUtc);
  
  final Guid noteId;
  final DateTime updatedAtUtc;
}
