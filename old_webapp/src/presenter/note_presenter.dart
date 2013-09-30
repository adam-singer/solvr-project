// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web;

class NotePresenter extends Presenter {
  NotePresenter(this._view)
    : _logger = LoggerFactory.getLogger(NotePresenter),
      _kernel = new Kernel()
  {
    _view.presenter = this;
    // Domain events
    messageBus.on[NoteDeleted].add(_onNoteDeleted);
    messageBus.on[NoteRenamed].add(_onNoteRenamed);
        
    // Application commands
    messageBus.on[EvaluateCurrentEntry].add((e) => _evaluateCurrentEntry());
    
    // Application events
    messageBus.on[EntrySelected].add((e) => _entrySelected(e.type));
  }
  
  renameNote(String newName) => messageBus.fire(new RenameCurrentNote(currentNote.id, newName));
  
  onEntrySelected(Type entryType) {
    if(entryType != null) {
      messageBus.fire(new EntrySelected(entryType));
    }
  }
  
  NoteDetails get noteDetails {
    return new NoteDetails(currentNote.name, currentNote.author, currentNote.createdAt, currentNote.updatedAt); 
  }
  
  _onCurrentNoteChanged(CurrentNoteChanged event) {
    Expect.equals(event.noteId, currentNote.id);
    _view.clear();
    _view.name = currentNote.name;
    for(var noteEntry in currentNote.content) {
      _view.addEntry(noteEntry);
    }
  }
  
  _onNoteDeleted(NoteDeleted event) => _view.clear();
  
  _onNoteRenamed(NoteRenamed event) {
    Expect.equals(event.noteId, currentNote.id);
    _view.name = event.newName;
  }
  
  _evaluateCurrentEntry() {
    Future<InputEntry> evaluation = currentNote.evaluateEntry(_view.currentEntry); 
    evaluation.then((InputEntry noteEntry) {
      var textResult = noteEntry.result;
      switch(currentUser.settings.outputFormat) {
        case OutputFormat.TEXT: 
          _view.updateTextEntry(noteEntry, textResult);
          break;
        case OutputFormat.MATH: 
          var exprResult = _kernel.parse(textResult);
          _view.updateMathEntry(noteEntry, exprResult);
          break;
        default:
          throw new ArgumentError("unsupported output format ${currentUser.settings.outputFormat}");
      }
      if(_isLastEntry(noteEntry)) {
        _view.addEntry(currentNote.addInputEntry());
      }
    });
    evaluation.handleException((InputEntryException e) => _view.entryError(e.entry, e.error));
  }
  
  bool _isLastEntry(NoteEntry noteEntry) => noteEntry.child == null;
  
  _entrySelected(Type entryType) {
    if(entryType != null) {
      _view.showKeyboardFor(entryType);
    }
  }
  
  final Logger _logger;
  final Kernel _kernel;
  NoteView _view;
}

abstract class NoteView extends View {
  addEntry(NoteEntry entry);
  
  clear();
  
  NoteEntry get currentEntry;
  
  List<NoteEntry> get content;
  
  set name(String noteName);
  
  entryError(NoteEntry entry, String errorMessage);
  
  updateTextEntry(NoteEntry entry, String textResult);
  
  updateMathEntry(NoteEntry entry, var mathResult);
  
  showKeyboardFor(Type type);
}

