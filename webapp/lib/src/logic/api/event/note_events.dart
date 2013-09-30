// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_api;

class NoteCreated extends NoteEvent {
  NoteCreated(this.noteName, Guid noteId, {this.deletable, this.editable, this.movable, this.renamable}): super(noteId);
  
  final String noteName;
  final deletable, editable, movable, renamable;
}

class NoteStarChanged extends NoteEvent {
  NoteStarChanged(this.starred, Guid noteId): super(noteId);
  
  final bool starred;
}

abstract class NoteEvent extends DomainEvent {
  NoteEvent(this.noteId);
  
  Guid noteId;
}