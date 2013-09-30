// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_api;

class CreateNote extends DomainCommand {
  CreateNote(this.noteName, [this.noteId = null]);
  
  final String noteName;
  final Guid noteId;
}

class StarNote extends DomainCommand {
  StarNote(this.noteId);
  
  final Guid noteId;
}

class UnstarNote extends DomainCommand {
  UnstarNote(this.noteId);
  
  final Guid noteId;
}

