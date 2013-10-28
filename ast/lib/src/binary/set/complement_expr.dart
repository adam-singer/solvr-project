// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/**
 * Set complement (usually A \ B)
 *
 * Fx:
 * - A = {a,b,c}
 * - B = {b,c,d}
 * - A \ B = { x | x in A && x notIn B } = {a}
 */
class ComplementExpr extends SimpleBinaryExpr {
  ComplementExpr(Expr left, Expr right): super(left, right, BinaryOperators.COMPLEMENT);

  @override
  Expr get clone => asComplement(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitComplementExpr(this);
}

ComplementExpr asComplement(Expr e1, Expr e2) => new ComplementExpr(e1, e2);
