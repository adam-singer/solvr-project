// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

/**
 * Modal widget with customizable content.
 *
 * Note: only one instance of this widget can be active at a time
 */
class ModalWidget {
  final int _heightPercentage;
  final int _widthPercentage;
  Element _content, _widget, _widgetBackground;
  
  ModalWidget(Element widgetContent): this.dimensions(widgetContent, 50, 50);
  
  ModalWidget.dimensions(Element widgetContent, this._heightPercentage, this._widthPercentage) {
    _widget = new Element.html("""
      <div class='widget-modal'>
        <div class='widget-modal-background'></div>
        <section class='widget-content'></section>
      </div>""");
    _widgetBackground = _widget.query(".widget-modal-background");
    _content = _widget.query(".widget-content");
    _content.nodes.add(widgetContent);
    
    // remove widget when user clicks outside of it
    _widget.onClick.listen((Event e) {
      if(!matchesParentOrSelf(e.target, 'widget-content')) {
        remove();
      }
    });
  }
  
  attachTo(Element container) {
    _widgetBackground.style.transition = 'opacity 0.1s ease-in';
    _widgetBackground.style.transition = 'opacity 0.2s ease-out';
    _content.style.transition = 'all 0.1s ease-in';
    _content.style.transition = 'all 0.2s ease-out';
    
    container.nodes.add(_widget);
    
    final num spaceOnEachSide = (100 - _widthPercentage)/2;
    final num spaceOverAndUnder = (100 - _heightPercentage)/2;
    
    _widgetBackground.style.opacity = "0.85";
    _content.style.opacity = "1";
    _content.style.top = "${spaceOverAndUnder}%";
    _content.style.left = "${spaceOnEachSide}%";
    _content.style.width = "${_widthPercentage}%";
    _content.style.height = "${_heightPercentage}%";
  }
  
  remove() { 
    final num height = _heightPercentage/2;
    final num width = _widthPercentage/2;
    final num spaceOnEachSide = (100 - width)/2;
    final num spaceOverAndUnder = (100 - height)/2;
    
    _widgetBackground.style.opacity = "0";
    _content.style.top = "${spaceOverAndUnder}%";
    _content.style.left = "${spaceOnEachSide}%";
    _content.style.width = "${width}%";
    _content.style.height = "${height}%";
    _content.style.opacity = "0";

    window.setTimeout(() {
      _widget.remove();
    }, 350);
  }
}
