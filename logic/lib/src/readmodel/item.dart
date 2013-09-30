// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

abstract class HistoryItem  {
  Guid get id;
  
  DateTime get lastUsed;
  
  String get name;
}

abstract class NoteItem extends HistoryItem { }

abstract class NotebookItem extends HistoryItem { }
