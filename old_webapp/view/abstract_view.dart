// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

abstract class AbstractView { 
  Element view;
  
  AbstractView(Element container) {
    view = new Element.html(template);
    container.nodes.add(view);
  }
  
  String get template;
}

