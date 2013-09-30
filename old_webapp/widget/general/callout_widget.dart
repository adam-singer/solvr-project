// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

/**
 * Callout widget with customizable content
 *
 * Note: only one instance of this widget can be active at a time
 */
class CalloutWidget {
  Element widget;
  
  CalloutWidget(Element content) {
    remove();
    
    widget = new Element.html(
    """
      <div class='widget-callout border-callout'>
        <section class='widget-content'></section>
        <b class='border-notch notch'></b>
        <b class='notch'></b>
      </div>
    """);
    widget.query(".widget-content").nodes.add(content);
    
    // remove widget when user clicks outside of it
    window.onClick.listen((Event e) {
      if(!matchesParentOrSelf(e.target, 'widget-callout')) {
        remove();
      }
    });
  }
  
  attachLeftOf(Element container) {
    container.nodes.add(widget);
  }
  
  attachBelowOf(Element container) {
    container.nodes.add(widget);
    widget.queryAll(".notch").forEach((Element notch) => notch.style.left = _middleOffset);
  }
  
  attachMiddleOf(Element container) {
    attachBelowOf(container);
    widget.style.marginLeft = "-${_middleOffset}";      
  }
  
  remove() => document.body.queryAll('.widget-callout').forEach((Element e) => e.remove());
  
  String get _middleOffset {
    int widgetWidth = widget.$dom_clientWidth;
    return"${(widgetWidth/2).round() - 10}px";
  }
}
