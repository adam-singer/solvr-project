// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

/**
 * Notes are an [AggregateRoot] so they contain their own eventlog, this way 
 * notes can be shared or moved between multiple users without loosing history. 
 * Also it it makes it easy to free up the storage when they are permanently 
 * deleted as you can just dump their persisted event stream entirely.
 */
class Note extends AggregateRoot {
  factory Note(String name, Guid noteId, {bool isDeletable:true, bool isEditable:true, bool isMovable:true, bool isRenamable:true}) {
    var note = new Note.fromId(noteId);
    note._recordEvent(new NoteCreated(name, noteId, deletable:isDeletable, editable:isEditable, movable:isMovable, renamable:isRenamable));
    return note;
  }
  
  Note.fromId(Guid noteId)
    : _starred = false,
      super(noteId);
  
  apply(DomainEvent event) {
    if(event is NotebookEvent) {
      if(event is NoteCreated) {
        _applyNoteCreated(event);
      }
      // enforce access control after creation
      _checkNoteAccess(event);
      
      if(event is NoteStarChanged) {
        _applyNoteStarChanged(event);
      } 
    }
  }
  
  starNote() { 
    if(!_starred) {
      _recordNoteEvent(new NoteStarChanged(true, id));
    }
  }
  
  unstarNote() {
    if(_starred) {
      _recordNoteEvent(new NoteStarChanged(false, id));
    }
  }
  
  _applyNoteCreated(NoteCreated event) {
    _name = event.noteName;
    _deletable = event.deletable;
    _editable = event.editable;
    _movable = event.movable;
    _renamable = event.renamable;
  }
  
  _applyNoteStarChanged(NoteStarChanged event) {
    _starred = event.starred;
  }
  
  _recordNoteEvent(NoteEvent event) {
    event.noteId = id;
    applyChange(event);
  }
  
  _checkNoteAccess(NoteEvent event) {
    if(this.id != event.noteId) {
      throw new StateError("cannot apply note event $event to note with id ${this.id}");
    }
  }
  
  bool _deletable, _editable, _movable, _renamable, _starred;
  String _name;
}