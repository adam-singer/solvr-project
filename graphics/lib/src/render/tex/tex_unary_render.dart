// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_tex;

class _TexUnaryRender extends _AbstractTexRender implements UnaryRender {
  _TexUnaryRender(StringBuffer buf, ExprRender render): super(buf, render);
  
  renderFactorial(FactorialExpr expr) {
    renderExpr(expr.operand);
    add(expr.token);
  }
  
  renderNegation(NegationExpr expr) {
    add(expr.token);
    renderExpr(expr.operand);
  }
  
  renderNegative(NegativeExpr expr) {
    add(expr.token);
    renderExpr(expr.operand);
  }
}
