// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_web_app;

class KeyboardWidget {
  KeyboardWidget() {
    _widget = new Element.html(""" 
      <article id='notebook-input'>
        <nav>
          <ul class='horizontal-list'></ul>
        </nav>
        <article class='widget-content'></article>
      </article>
    """);
    _widget.style.transition = "all 0.3s ease-in-out";
    _buttonList = _widget.query("ul");
    _content = _widget.query(".widget-content");
    _attached = false;
  }
  
  toggleOn(Element container) {
    if(_attached) {
      remove();     
    } else {
      attachTo(container);
    }
  }
  
  attachTo(Element container) {
    _widget.style.transition = 'all 0.3s ease-in-out';
    
    container.nodes.add(_widget);
    _attached = true;
    
    window.setTimeout(() {
      _widget.style.opacity = "1";
      _widget.style.width = "${_widthPercentage}%";
      _widget.style.height = "${_heightPercentage}%";
      _widget.style.top = "55%";
      _widget.style.left = "2%";
    }, 2);
  }
  
  remove() { 
    final num height = _heightPercentage/2;
    final num width = _widthPercentage/2;
    final num spaceOnEachSide = (100 - width)/2;
    final num spaceOverAndUnder = (100 - height)/2;
    
    _widget.style.width = "${width}%";
    _widget.style.height = "${height}%";
    _widget.style.top = "65%";
    _widget.style.left = "25%";
    _widget.style.opacity = "0";

    window.setTimeout(() {
      _widget.remove();
      _attached = false;
    }, 300);
  }
  
  showFor(Type type) {
    AreaType area = _typeAreas[type];
    if(area != null) {
      _content.nodes.add(new Element.html("<p>Paragraph</p>"));
    }
  }
  
  Element _buttonList, _content, _widget;
  bool _attached;
  
  final int _heightPercentage = 40;
  final int _widthPercentage = 96;
  
  Map<AreaType, Element> _areaWidgets;
  Map<Type, AreaType> _typeAreas;
}
