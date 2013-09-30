// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

/**
 * Item Grid
 *
 * Note: only one instance of this widget can be active at a time
 */
class GridWidget extends ModalWidget {
  factory GridWidget(Element navContent, Element gridContent) {
     Element widget = new Element.html(""" 
       <section class='widget-grid'>
         <nav></nav>
         <section class='widget-content'></section>
       </section>
     """);
     
     Element nav = widget.query("nav");
     navContent.classes.add("widget-grid-nav-content");
     nav.nodes.add(navContent);
     
     Element closer = new Element.html("<span class='widget-close'></span>");
     closer.onClick.listen((Event e) => widget.remove());
     nav.nodes.add(closer);
     
     widget.query(".widget-content").nodes.add(gridContent);
     
     return new GridWidget._internal(widget);
  }
  
  GridWidget._internal(Element widgetContent): super.dimensions(widgetContent, 80, 80);
}
