// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web;

class EvaluateCurrentEntry extends ApplicationCommand { }

class DeleteCurrentNotebook extends ApplicationCommand { }

class ToogleWidgets extends ApplicationCommand { }

class EntrySelected extends ApplicationCommand {
  EntrySelected(this.entryType);
  
  final Type entryType;
}
