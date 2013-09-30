// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class ActivityWidget {
  ActivityWidget() {
    _widget = new Element.html(""" 
       <ul class='vertical-list'></ul>
     """);
  }
  
  addActivity(NotebookActivity activity) {
    // TODO add gravatar
    Element elm = new Element.html("""
        <li>
            <img class='gravatar' src='${activity.gravatarUrl}'/>
            <span class='description' >${activity.description}</span>
        </li>
    """); 
    Element first = _widget.query('li:first-child');
    if(first != null) {
      _widget.insertBefore(elm, first);
    } else {
      _widget.nodes.addLast(elm);
    }
  }
  
  attachTo(Element parent) {
    parent.nodes.add(_widget);
  }
  
  Element _widget;
}
