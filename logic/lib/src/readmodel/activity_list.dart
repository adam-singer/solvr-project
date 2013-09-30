// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

abstract class ActivityList extends IdModel {
  List<NoteActivity> get all;
}

class NoteActivity {
  NoteActivity(this.noteId, this.type, this.userId, this.description);
  
  // TODO replace 123 with userId
  String get gravatarUrl => "resources/users/123/gravatar.jpg";
  
  final String type, description; 
  final Guid noteId, userId;
}



