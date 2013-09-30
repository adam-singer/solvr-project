// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic;

/**
 * Application settings for the [User]
 */
class Settings extends EventSourcedEntity {
  factory Settings.defaults(User user) {
    return new Settings._internal(user, true, true, OutputFormat.MATH);
  }
  
  Settings._internal(User user, this._automaticSimplify, this._showToolTips, this._outputFormat): super(user);
  
  Settings(User user): super(user);
  
  apply(var event) {
    if(event is AutomaticSimplifyChanged) {
      _automaticSimplify = event.automaticSimplify;
    }
    if(event is ShowToolTipsChanged) {
      _showToolTips = event.showToolTips;
    }
    if(event is OutputFormatChanged) {
      _outputFormat = OutputFormat.valueOf(event.formatType);
    }
  }
  
  /**
   * When true expressions are automatically simplified as they are entered
   */
  bool get automaticSimplify => _automaticSimplify; 
  
  set automaticSimplify(bool val) {
    if(val != automaticSimplify) {
      applyChange(new AutomaticSimplifyChanged(val));
    }
  }
  
  /**
   * When true tool tips are shown accross the application
   */
  bool get showToolTips => _showToolTips;
  
  set showToolTips(bool val) {
    if(val != showToolTips) {
      applyChange(new ShowToolTipsChanged(val));
    }
  }
  
  // TODO see if we can kill this somehow
  OutputFormat get outputFormat => _outputFormat;
  
  set outputFormat(OutputFormat val) {
    if(val != _outputFormat) {
      applyChange(new OutputFormatChanged(val.type));
    }
  }
  
  bool _automaticSimplify, _showToolTips, _showSmartHelp, _showSmartInput;
  Language _defaultNotebookLanguage;
  OutputFormat _outputFormat;
  int _utcOffset;
  // TODO notebook fontsize and fontcolor
}


