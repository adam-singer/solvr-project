// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class HelpWidget {
  HelpWidget(List<AreaType> areas, Map<String, List<FunctionObject>> functions) {
    _widget = new Element.html("""
      <article class='widget-help'> 
        <h2>Areas</h2>
        <ol class='widget-help-areas'></ol>
      </article>
     """);
    
    var helpAreas = _widget.query("ol");
    areas.forEach((AreaType area) {
      var areaEntry = new Element.html(""" 
        <li><a href='#'>${area.name}</a></li>
      """);
      helpAreas.nodes.add(areaEntry);
    });
  }
  
  attachTo(Element parent) {
    parent.nodes.add(_widget);
  }
  
  Element _widget;
  
  // TODO show keyboard short cuts like in fluent
  /*
   var areas = registry.areas;
      Expect.equals(areas.length, 3);
      
      areas.forEach((AreaType area) {
        var functions = registry.getFunctionsFor(area);
        functions.forEach((name,list) {
          print("found function $name for $area");
          Expect.isFalse(list.isEmpty(), "no functions found for $name");
        });
      });
      */
}
