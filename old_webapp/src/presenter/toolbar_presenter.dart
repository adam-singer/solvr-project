// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web;

class ToolbarPresenter extends Presenter {
  ToolbarPresenter(this._view): _logger = LoggerFactory.getLogger(ToolbarPresenter) {
    _view.presenter = this;
  }
  
  onNewNote() {
    messageBus.fire(new CreateNote());
  }
  
  onSaveNote() {
    messageBus.fire(new SaveNote(currentNote.id));
  }
  
  onShareNote() {
    _view.shareNote(currentNote.name);
  }
  
  onDiscoverNotes() {
    _logger.debug("onDiscoverNotes");
  }
  
  onEvaluate() {
    messageBus.fire(new EvaluateCurrentEntry());
  }
  
  onShowWidgets() {
    messageBus.fire(new ToogleWidgets());
  }
  
  onShowSettings() {
    _view.showSettings(currentUser.settings);
  }
  
  final Logger _logger;
  ToolbarView _view;
}

abstract class ToolbarView extends View {
  showSettings(Settings settings);
  
  shareNote(String noteName);
}
 
