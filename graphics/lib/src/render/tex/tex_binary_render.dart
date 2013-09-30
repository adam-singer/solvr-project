// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_graphics_render_tex;

/** See http://www.access2science.com/latex/Binary.html */
class _TexBinaryRender extends _AbstractTexRender implements BinaryRender {
  _TexBinaryRender(StringBuffer buf, ExprRender render): super(buf, render);
  
  // Algebraic expressions 
  renderDifference(DifferenceExpr expr) => _renderBinary(expr, r"-");
  
  renderDot(DotExpr expr) => _renderBinary(expr, r"\cdot");
  
  renderFraction(FractionExpr expr) {
    add(r"\frac{\displaystyle ");
    renderExpr(expr.left);
    add(r"}{\displaystyle ");
    renderExpr(expr.right);
    add(r"}");
  }
  
  renderPower(PowerExpr expr) {
    var base = baseOf(expr);
    var exponent = exponentOf(expr);
    
    if(isQuotient(exponent)) {
      if(isHalf(exponent)) {
        add(r"\sqrt{");
        renderExpr(base);
        add(r"}");
      } else {
        add(r"\sqrt[" + exponent.toString() + r"]{");
        renderExpr(base);
        add(r"}");
      }
    } else {
      renderExpr(base);
      add(r"^{");
      renderExpr(exponent);
      add(r"}");
    }
  }
  
  // Logical expressions 
  renderAnd(AndExpr expr) => _renderBinary(expr, r"\wedge");
  
  renderOr(OrExpr expr) => _renderBinary(expr, r"\vee");
  
  // Object expressions 
  
  // Relational expressions 
  renderEqual(EqualExpr expr) => _renderBinary(expr, r" = ");
  
  renderGreaterThan(GreaterThanExpr expr) => _renderBinary(expr, r">");
  
  renderGreaterThanOrEqual(GreaterThanOrEqualExpr expr) => _renderBinary(expr, r"\geq");
  
  renderLessThan(LessThanExpr expr) => _renderBinary(expr, r"<");
  
  renderLessThanOrEqual(LessThanOrEqualExpr expr) => _renderBinary(expr, r"\leq");
  
  renderNotEqual(NotEqualExpr expr) => _renderBinary(expr, r"\neq");
  
  // Set expressions 
  renderComplement(ComplementExpr expr) => _renderBinary(expr, r"\setminus");
  
  renderIntersect(IntersectExpr expr) => _renderBinary(expr, r"\cap");
  
  renderNotSubset(NotSubsetExpr expr)  => _renderBinary(expr, r"\not\subset");
  
  renderSubset(SubsetExpr expr)  => _renderBinary(expr, "@\subset");
    
  renderUnion(UnionExpr expr)  => _renderBinary(expr, r"\cup");
  
  // Helpers 
  _renderBinary(BinaryExpr expr, String token) {
    renderExpr(expr.left);
    add(" ");
    add(token);
    add(" ");
    renderExpr(expr.right);
  }
}


