// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

/*
class InputWidget {
  InputWidget():
    _areas = new Map<AreaType, _InputWidget>(),
    _keys = new Map<TextKey, _InputWidget>()
  {
    // register widgets
    //_registerInputWidget(new _LinearAlgebraWidget());
    
    // default widget
    //_showWidget(arithmeticWidget);
  }
  
  _registerInputWidget(_InputWidget inputWidget) {
    inputWidget.button.on.click.add((MouseEvent clickEvent) => _showWidget(inputWidget));
    // add button
    Element buttonEntry = new Element.html("<li></li>");
    buttonEntry.nodes.add(inputWidget.button);
    _buttonList.nodes.add(buttonEntry);
    // register keys and areas handled by widget
    //inputWidget.keys.getKeys().forEach((TextKey key) => _keys[key] = inputWidget);
    _areas[inputWidget.area] = inputWidget;
  }
  
  _showWidget(_InputWidget inputWidget) {
    Element formerActive = _buttonList.query(".active");
    if(formerActive !== null) {
      formerActive.classes.remove("active");
    }
    inputWidget.button.classes.add("active");
    
    _content.nodes.clear();
    _content.nodes.add(inputWidget.content);
  }
  
  showWidgetFor(AreaType area) => _showWidget(_areas[area]);
  
  final Map<TextKey, _InputWidget> _keys;
  final Map<TextArea, _InputWidget> _areas;
}
*/
