// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Complex number fx. 3+i4 */
class ComplexNumberExpr extends BinaryExpr {
  ComplexNumberExpr(Expr left, Expr right): super(left, right, BinaryOperators.COMPLEX);
  
  @override
  Expr get clone => asComplexNumber(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitComplexNumberExpr(this);
}

ComplexNumberExpr asComplexNumber(Expr e1, Expr e2) => new ComplexNumberExpr(e1, e2);
