// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_svg;

class _SvgUnaryRender extends _AbstractSvgRender implements UnaryRender {
  _SvgUnaryRender(Element element, Element glyphs): super(element, glyphs);
  
  renderFactorial(FactorialExpr expr) {
    mathRender.render(expr.operand);
    addText("&#x021;");
  }
  
  renderNegation(NegationExpr expr) {
    addText("&#x021;");
    mathRender.render(expr.operand);
  }
  
  renderNegative(NegativeExpr expr) {
    addText("&#x02d;");
    mathRender.render(expr.operand);
  }
}
