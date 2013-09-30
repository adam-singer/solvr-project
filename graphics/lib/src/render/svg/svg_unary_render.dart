// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_graphics_render_svg;

class _SvgUnaryRender extends _AbstractSvgRender implements UnaryRender {
  _SvgUnaryRender(Element element, FontManager fontManager, ExprRender render): super(element, fontManager, render);
  
  @override
  renderFactorial(FactorialExpr expr) {
    renderExpr(expr.operand);
    addText("&#x021;");
  }
  
  @override
  renderNegation(NegationExpr expr) {
    addText("&#x021;");
    renderExpr(expr.operand);
  }
  
  @override
  renderNegative(NegativeExpr expr) {
    addText("&#x02d;");
    renderExpr(expr.operand);
  }
}
