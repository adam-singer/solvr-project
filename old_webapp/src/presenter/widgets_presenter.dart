// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web;

class WidgetsPresenter extends Presenter {
  WidgetsPresenter(this._view, this._activityList)
    : _logger = LoggerFactory.getLogger(WidgetsPresenter),
      _registry = new Registry()
  {
    _view.presenter = this;
    
    // application commands
    messageBus.on[ToogleWidgets].add((e) => _view.toogle());
    messageBus.on[EntrySelected].add((EntrySelected selected) => _view.showHelpForType(selected.entryType));
    
    // show help widget by default
    onShowHelp();
  }

  onShowActivity() {
    _view.showActivities(_activityList.all);
  }
  
  onShowHelp() {
    var areas = _registry.areas;
    _view.showHelp(areas);
  }
  
  final ActivityList _activityList;
  final Registry _registry;
  final WidgetsView _view;
  final Logger _logger;
}

abstract class WidgetsView extends View {
  showHelp(List<AreaType> areas);
  
  //showHelpForArea(Map<String, List<FunctionObject>>)
  
  showHelpForType(Type type);
  
  showActivities(List<NotebookActivity> activities);
  
  toogle();
}

