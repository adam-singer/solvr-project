// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

// TODO save using a real model repo
class EventHandler {
  @inject
  EventHandler(this._messageBus, this._viewModelRepository) {
    // user events
    _messageBus.stream(NotebookCreated).listen(_notebookCreated);
    _messageBus.stream(NoteAddedToNotebook).listen(_noteAddedToNotebook);
    
    // note events
    _messageBus.stream(NoteCreated).listen(_noteCreated);
  }
  
  _notebookCreated(NotebookCreated event) {
    var notebook = new NotebookViewModelImpl(event);
    _viewModelRepository._notebooks[notebook.id] = notebook;
  }
  
  _noteCreated(NoteCreated event) {
    var note = new NoteViewModelImpl(event);
    _viewModelRepository._notes[note.id] = note;
  }
  
  _noteAddedToNotebook(NoteAddedToNotebook event) {
    var notebook = _viewModelRepository.getNotebook(event.notebookId);
    var note = _viewModelRepository.getNote(event.noteId);
    notebook.notes.add(note);
  }
  
  final MessageBus _messageBus;
  final ViewModelRepositoryImpl _viewModelRepository;
}