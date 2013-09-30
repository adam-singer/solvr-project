// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class NotebookCommandHandler extends CommandHandler {
  NotebookCommandHandler(this._notebookRepository) {
    messageBus.sink(CreateNotebook).add(_onCreateNotebook);
    messageBus.sink(DeleteNotebook).add(_onDeleteNotebook);
    messageBus.sink(AddNoteToNotebook).add(_onAddNoteToNotebook);
    messageBus.sink(AddNotebookToNotebook).add(_onAddNotebookToNotebook);
  }
  
  // TODO notebook moved event
  _onCreateNotebook(CreateNotebook command) {
    inContext(command, _logger, () {
      Notebook notebook = new Notebook(command.notebookName);
      _notebookRepository.save(notebook);
    });
  }
  
  _onDeleteNotebook(DeleteNotebook command) {
    inContext(command, _logger, () {
      _notebookRepository.load(command.notebookId).then((Notebook notebook) {
        notebook.delete();
        _notebookRepository.save(notebook);
      });
    });
  }
  
  _onAddNoteToNotebook(AddNoteToNotebook command) {
    inContext(command, _logger, () {
      _notebookRepository.load(command.targetId).then((Notebook notebook) {
        notebook.addNote(command.noteId);
        _notebookRepository.save(notebook);
      });
    });
  }
  
  _onAddNotebookToNotebook(AddNotebookToNotebook command) {
    // TODO simplify these inContext calls (perhaps using currying)
    inContext(command, _logger, () {
      _notebookRepository.load(command.targetId).then((Notebook notebook) {
        notebook.addNotebook(command.notebookId);
        _notebookRepository.save(notebook);
      });
    });
  }
  
  final DomainRepository<Notebook> _notebookRepository;
  static final _logger = LoggerFactory.getLoggerFor(NotebookCommandHandler);
}

