// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_api;

/*
abstract class UserViewModel {
  List<NotebookViewModel> get userNotebooks;
  
  NotebookViewModel get starredNotes;
  
  NotebookViewModel get scrapbook;
}
*/

abstract class NotebookViewModel  {
  Guid get id;
  
  String get name;

  List<NoteViewModel> get notes;
  
  List<NoteViewModel> get starred;
  
  // TODO position
}

abstract class NoteViewModel {
  String get name;
  
  Guid get id;
  
  bool get starred;
  
  // TODO movable, editable, lastUsed (for sorting)
}



