// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_api;

class AddNoteToNotebook extends DomainCommand {
  AddNoteToNotebook({this.noteId, this.notebookId});
  
  final Guid noteId, notebookId;
}

class CreateNotebook extends DomainCommand {
  CreateNotebook(this.notebookName, [this.notebookId = null]);
  
  final String notebookName;
  final Guid notebookId;
}

class CreateUser extends DomainCommand {
  CreateUser(this.username);
  
  final String username;
}