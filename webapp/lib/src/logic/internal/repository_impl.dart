// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_internal;

 // TODO use view model repo
class ViewModelRepositoryImpl implements ViewModelRepository {
  @override
  String activeResourceUrl;

  
  // TODO use a repository
  @override
  NotebookViewModel getNotebook(Guid id) => _notebooks[id];
  
  @override
  NoteViewModel getNote(Guid id) => _notes[id];
  
  @override
  Iterable<NotebookViewModel> get notebooks => _notebooks.values;
  
  @override
  Iterable<NoteViewModel> get sharedNotes => _starredNotes.map(getNote);
  
  @override
  Iterable<NoteViewModel> get starredNotes => _starredNotes.map(getNote);
  
  final _notebooks = new Map<Guid, NotebookViewModel>();
  final _notes = new Map<Guid, NoteViewModel>();
  final _starredNotes = new Set<Guid>();
  final _sharedNotes = new Set<Guid>();
}

