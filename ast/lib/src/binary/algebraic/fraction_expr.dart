// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Fractions fx. (x+1)/5 or 1/2 */
class FractionExpr extends BinaryExpr {
  FractionExpr(Expr left, Expr right): super(left, right, BinaryOperators.FRACTION);

  @override
  Expr get clone => (left.clone)/(right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitFractionExpr(this);
}

FractionExpr asFraction(Expr left, Expr right) => new FractionExpr(left, right);


