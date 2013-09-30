// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_api;

// TODO move this stuff to user
abstract class ViewModelRepository {
  /// The URL of the last active resource, usefull for opening the app at its last position
  dynamic get activeResourceUrl;
  
  NotebookViewModel getNotebook(Guid id);
  
  NoteViewModel getNote(Guid id);
  
  Iterable<NotebookViewModel> get notebooks;
  
  Iterable<NoteViewModel> get sharedNotes;
  
  Iterable<NoteViewModel> get starredNotes;
}

