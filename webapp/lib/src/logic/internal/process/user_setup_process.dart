// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

class UserSetupProcess {
  UserSetupProcess(this._messageBus, this._userId): processId = new Guid();
  
  run() {
    _notebookId = new Guid();
    _subscriptions.add( _messageBus.stream(NotebookCreated).listen(_notebookCreated) );
    _messageBus.fire(new CreateNotebook("My first notebook", _notebookId));
  }
  
  _notebookCreated(NotebookCreated event) {
    if(event.userId == _userId && event.notebookId == _notebookId) {
      _noteId = new Guid();
      _subscriptions.add( _messageBus.stream(NoteCreated).listen(_noteCreated) );
      _messageBus.fire(new CreateNote("My first notebook", _noteId));
    }
  }
  
  _noteCreated(NoteCreated event) {
    if(event.noteId == _noteId) {
      _subscriptions.add( _messageBus.stream(NoteAddedToNotebook).listen(_noteAddedToNotebook) );
      _messageBus.fire(new AddNoteToNotebook(noteId:_noteId, notebookId:_notebookId));
    }
  }
  
  _noteAddedToNotebook(NoteAddedToNotebook event) {
    if(event.noteId == _noteId && event.notebookId == _notebookId) {
      _subscriptions.forEach((s) => s.cancel());
      _messageBus.fire(new UserSetupCompleted(userId:_userId, processId:this.processId));
    }
  }
  
  Guid _notebookId, _noteId;
  final _subscriptions = new List<StreamSubscription>(); 
  final Guid _userId, processId;
  final MessageBus _messageBus;
}



