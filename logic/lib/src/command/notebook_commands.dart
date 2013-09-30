// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class CreateNotebook extends DomainCommand {
  CreateNotebook(this.notebookName);
  
  final String notebookName;
}

class DeleteNotebook extends DomainCommand {
  DeleteNotebook(this.notebookId);
  
  final Guid notebookId;
}

class AddNoteToNotebook extends DomainCommand {
  AddNoteToNotebook(this.noteId, this.targetId);
  
  final Guid targetId, noteId;
}

class AddNotebookToNotebook extends DomainCommand {
  AddNotebookToNotebook(this.notebookId, this.targetId);
  
  final Guid targetId;
  final Guid notebookId;
}
