// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

/*
abstract class _InputWidget {
  Element _controls;
  
  final Map<TextKey, Element> keys;
  final TextArea area;
  
  ControlListener onControlClick;
  Element button;
  Element content;
  
  _InputWidget(this.area, String widgetClass)
    : keys = new Map<TextKey,Element>() 
  {
    content = new Element.html("""
      <section class='${widgetClass}'>
        <article class='widget-input-controls'>
          <ul class='horizontal-list'></ul>
        </article>
      </section>
    """);
    _controls = content.query("ul");
    button = new Element.html("<button><a href='#'>${area.name}</a></button>");
  }
  
  registerControl(TextKey key) {
    Element control = new Element.html("""
      <li>
        <button><a href="#">${key.name}</a></button>
      </li>
    """);
    control.query("button").on.click.add((MouseEvent event) => onControlClick(key));
    _controls.nodes.add(control);
    keys[key] = control;
  }
}

typedef ControlListener(TextKey key);
*/

