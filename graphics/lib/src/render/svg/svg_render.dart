// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_svg;

/** [ExprRender] that renders expressions as SVG */
class SvgRender implements ExprRender<Element,Element> {
  factory SvgRender() {
    if(_instance == null) {
      _instance = new SvgRender._internal();
    }
    return _instance;
  }
  
  SvgRender._internal();
  
  /*
   * Links
   * - svg and text: http://www.svgbasics.com/simple_text.html
   * - unicode and math: http://unicode.org/reports/tr25/tr25-5.html
   * - unicode chars: http://en.wikipedia.org/wiki/List_of_Unicode_characters
   */
  
  Element render(Expr expr) {
    _init();
    _mathRender.render(expr);
    return _element;
  }
  
  attachTo(Element target) {
    print("attaching content ${_element.innerHTML}");
    target.nodes.add(_element);
  }
  
  renderAndAttach(Expr expr, Element target) {
    render(expr);
    attachTo(target);
  }
  
  _init() {
    var canvas = new SvgElement.svg("<g stroke='black' fill='black' stroke-thickness='0' transform='matrix(1 0 0 -1 0 0)'>");
    
    // MathHI = https://github.com/mathjax/MathJax/blob/master/unpacked/jax/output/SVG/fonts/TeX/Math/Italic/Main.js
    // <path id="MJMATHI-74" stroke-width="10" d="M"></path>
    _element = new SvgElement.tag("svg");
    _element.nodes.add(canvas);
    _element.attributes = {
      "height": 50,
      "width": 800,
      "version": "1.2"
    };
    var fontManager;
    
    var binaryRender = new _SvgBinaryRender(canvas, fontManager);
    var naryRender = new _SvgNaryRender(canvas, fontManager);
    var nullaryRender = new _SvgNullaryRender(canvas, fontManager);
    var specialRender = new _SvgSpecialRender(canvas, fontManager);
    var unaryRender = new _SvgUnaryRender(canvas, fontManager);
    
    _mathRender = new MathRender(binaryRender, naryRender, nullaryRender, specialRender, unaryRender);
  }
  
  SvgElement _element;
  Render _mathRender; 
  static SvgRender _instance;
}
  
 
