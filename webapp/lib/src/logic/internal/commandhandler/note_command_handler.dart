// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

class NoteCommandHandler {
  factory NoteCommandHandler(MessageBus messageBus, EventStore eventStore) {
    var noteRepository = new DomainRepository<Note>((id) => new Note.fromId(id), eventStore, messageBus);
    return new NoteCommandHandler._internal(messageBus, noteRepository);
  }
  
  NoteCommandHandler._internal(MessageBus messageBus, this._noteRepository) {
    messageBus.stream(CreateNote).listen(_createNote);
    messageBus.stream(StarNote).listen(_starNote);
    messageBus.stream(UnstarNote).listen(_unstarNote);
  }
  
  _createNote(CreateNote command) {
    var noteId = command.noteId != null ? command.noteId : new Guid();
    var note = new Note(command.noteName, noteId);
    _noteRepository.save(note).then((_) => command.completeSuccess());
  }
  
 _starNote(StarNote command) {
    _noteRepository.load(command.noteId).then((Note note) {
      note.starNote();
      _noteRepository.save(note).then((_) => command.completeSuccess());
    });
  }
  
  _unstarNote(UnstarNote command) {
    _noteRepository.load(command.noteId).then((Note note) {
      note.unstarNote();
      _noteRepository.save(note).then((_) => command.completeSuccess());
    });
  }
  
  final DomainRepository<Note> _noteRepository;
}