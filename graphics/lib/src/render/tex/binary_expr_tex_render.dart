// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_graphics_tex_render;

/** See http://www.access2science.com/latex/Binary.html */
abstract class BinaryExprTexRender implements BinaryExprVisitor {
  visitComplexNumberExpr(ComplexNumberExpr expr);
  
  @override
  visitDifferenceExpr(DifferenceExpr expr) => _renderBinary(expr, r"-");
  
  @override
  visitDotExpr(DotExpr expr) => _renderBinary(expr, r"\cdot");
  
  @override
  visitFractionExpr(FractionExpr expr) {
    add(r"\frac{\displaystyle ");
    renderExpr(expr.left);
    add(r"}{\displaystyle ");
    renderExpr(expr.right);
    add(r"}");
  }
  
  @override
  visitPowerExpr(PowerExpr expr) {
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
  
  @override
  visitAndExpr(AndExpr expr) => _renderBinary(expr, r"\wedge");
  
  @override
  visitOrExpr(OrExpr expr) => _renderBinary(expr, r"\vee");
  
  visitBindExpr(BindExpr expr);
  
  visitGuardExpr(GuardExpr expr);
  
  visitInstanceOfExpr(InstanceOfExpr expr);
  
  visitNotInstanceOfExpr(NotInstanceOfExpr expr);
  
  visitSubsitutionExpr(SubstitutionExpr expr);
  
  @override
  visitEqualExpr(EqualExpr expr) => _renderBinary(expr, r" = ");
  
  @override
  visitGreaterThanExpr(GreaterThanExpr expr) => _renderBinary(expr, r">");
  
  @override
  visitGreaterThanOrEqualExpr(GreaterThanOrEqualExpr expr) => _renderBinary(expr, r"\geq");
  
  @override
  visitLessThanExpr(LessThanExpr expr) => _renderBinary(expr, r"<");
  
  @override
  visitLessThanOrEqualExpr(LessThanOrEqualExpr expr) => _renderBinary(expr, r"\leq");
  
  @override
  visitNotEqualExpr(NotEqualExpr expr) => _renderBinary(expr, r"\neq");
  
  @override
  visitComplementExpr(ComplementExpr expr) => _renderBinary(expr, r"\setminus");
  
  visitEntryExpr(EntryExpr expr);
  
  @override
  visitIntersectExpr(IntersectExpr expr) => _renderBinary(expr, r"\cap");
  
  @override
  visitNotSubsetExpr(NotSubsetExpr expr) => _renderBinary(expr, r"\not\subset");
  
  @override
  visitSubsetExpr(SubsetExpr expr) => _renderBinary(expr, "@\subset");
  
  @override
  visitUnionExpr(UnionExpr expr) => _renderBinary(expr, r"\cup");
  
  // Helpers 
  _renderBinary(BinaryExpr expr, String token) {
    renderExpr(expr.left);
    add(" ");
    add(token);
    add(" ");
    renderExpr(expr.right);
  }
}


