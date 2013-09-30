// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_tex;

abstract class _AbstractTexRender {
  _AbstractTexRender(this._buf, this._exprRender); 
  
  renderOperands(String start, String delimiter, String end, List<Expr> operands) {
    add(start);
    mapI(operands, (Expr elm, int i) {
      renderExpr(elm);
      if(i < operands.length - 1) {
        add(delimiter);
      }
    });
    add(end); 
  }
  
  add(String str) => _buf.write(str);
  
  renderExpr(Expr expr) => _exprRender.render(expr);
  
  final ExprRender _exprRender;
  final StringBuffer _buf;
}
