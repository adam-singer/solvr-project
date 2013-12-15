// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_text;

/** The default English text repository */
class TextRepository {
  factory TextRepository() {
    // TODO switch between danish / english version
    if(_instance == null) {
      _instance = new TextRepository._internal();
    }
    return _instance;
  }
  
  TextRepository._internal();
  
  // Text values 
  final String account = "Account";
  final String accountTooltip = "Account";
  final String calculate = "Calculate";
  final String cancel = "Cancel";
  final String deleteNote = "Delete Note";
  final String deleteNotebook = "Delete Notebook";
  final String help = "Help";
  final String newNote = "Add Note";
  final String newNotebook = "Add Notebook";
  final String notebooks = "Notebooks";
  final String ok = "OK";
  final String saveNote = "Save";
  final String search = "Search";
  final String scrapbook = "Scrapbook";
  final String searchTooltip = "Search";
  final String settingsTooltip = "Settings";
  final String starred = "Starred";
  final String trashTooltip = "Trash";
  final String tools = "Tools";
  
  // Text functions 
  //String deleteNote(String note) => "Delete ${note}";
  //String deleteNotebook(String notebook) => "Delete ${notebook}";

  static TextRepository _instance;
} 

