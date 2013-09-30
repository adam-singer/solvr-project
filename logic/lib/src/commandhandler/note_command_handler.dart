// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class NoteCommandHandler extends CommandHandler {
  NoteCommandHandler(this._noteRepository) {
    messageBus.sink(CreateNote).add(_onCreateNote);
    messageBus.sink(DeleteNote).add(_onDeleteNote);
    messageBus.sink(RenameNote).add(_onRenameNote);
    messageBus.sink(SaveNote).add(_onSaveNote);
  }
  
  _onCreateNote(CreateNote command) {
    inContext(command, _logger, () {
      _noteCount++;
      Note note = new Note("Untitled ${_noteCount}");
      // TODO if first note show a intro text
      note.addInputEntry("Write expression here");
      _logger.info("creating note [${note.name}]");
      _noteRepository.save(note);
    });
  } 
  
  _onDeleteNote(DeleteNote command) {
    inContext(command, _logger, () {
      _noteRepository.load(command.noteId).then((Note note) {
        _logger.info("deleting note [${note.name}]");
        note.delete();
        // save the note to emit the delete events 
        _noteRepository.save(note);
      });
    });
  }
  
  _onRenameNote(RenameNote command) {
    inContext(command, _logger, () {
      _noteRepository.load(command.noteId).then((Note note) {
        note.name = command.newName;
        _noteRepository.save(note);
      });
    });
  } 
  
  _onSaveNote(SaveNote command) {
    inContext(command, _logger, () {
      throw "TODO save is unimplemented";
    });
  } 
  
  
  // number of note's created in this session
  // TODO move to session context
  static int _noteCount = 0;
  
  final DomainRepository<Note> _noteRepository;
  static final _logger = LoggerFactory.getLoggerFor(NoteCommandHandler);
}
