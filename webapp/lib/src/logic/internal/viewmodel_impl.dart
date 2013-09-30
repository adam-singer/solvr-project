// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

class NotebookViewModelImpl implements NotebookViewModel  {
  NotebookViewModelImpl(NotebookCreated event)
      : id = event.notebookId,
        name = event.notebookName;
  
  @override
  final Guid id;
  
  @override
  String name;
  
  @override
  List<NoteViewModel> notes = [];
  
  @override
  List<NoteViewModel> get starred => notes.where((n) => n.starred == true);
}

class NoteViewModelImpl implements NoteViewModel {
  NoteViewModelImpl(NoteCreated event)
    : id = event.noteId,
      name = event.noteName,
      starred = false;
  
  @override
  final Guid id;
  
  @override
  String name;
  
  @override
  bool starred;
}

