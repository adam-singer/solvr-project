// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class CreateNote extends DomainCommand { }

class DeleteNote extends DomainCommand {
  DeleteNote(this.noteId);
  
  final Guid noteId;
}

class SaveNote extends DomainCommand {
  SaveNote(this.noteId);
  
  final Guid noteId;
}

class RenameNote extends ApplicationCommand {
  RenameNote(this.noteId, this.newName);
  
  final Guid noteId;
  final String newName;
}


