// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

class NoteDetails {
  NoteDetails(this.title, this.author, DateTime createdAt, DateTime updatedAt) {
    created = createdAt.toString();
    updated = updatedAt.toString();
    // TODO remove when we can actually share/sync
    shareStatus = "not shared";
    syncStatus = "not synced";
  }
  
  String title, author, created, updated, shareStatus, syncStatus;
}
