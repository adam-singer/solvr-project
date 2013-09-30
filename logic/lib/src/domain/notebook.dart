// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class Notebook extends AggregateRoot {
  Set<Guid> _folders;
  Set<Guid> _notebooks;
  String _name;
  
  Notebook(String name)
    : _folders = new Set<Guid>(),
      _notebooks = new Set<Guid>() 
  {
    applyChange(new NotebookCreated(new Guid(), name));
  }
  
  Notebook.fromId(Guid folderId)
   : _folders = new Set<Guid>(),
     _notebooks = new Set<Guid>()
  {
    id = folderId;
  }
  
  apply(var event) {
    
  }

  addNote(Guid notebookId) {
    applyChange(new NoteAddedToNotebook(notebookId, id));
  }

  removeNote(Guid notebookId) {
    if(_notebooks.contains(notebookId)) {
      applyChange(new NoteRemovedFromNotebook(notebookId, id));
    }
  }
  
  addNotebook(Guid folderId) {
    applyChange(new NotebookAddedToNotebook(folderId, id));
  }

  removeNotebook(Guid folderId) {
    if(_folders.contains(folderId)) {
      applyChange(new NotebookRemovedFromNotebook(folderId, id));
    }
  }

  delete() {
    applyChange(new NotebookDeleted(id, _folders, _notebooks));
  }
}
