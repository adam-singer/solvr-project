// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Logical disjunction (\/) fx: a or b */
class OrExpr extends BinaryExpr {
  OrExpr(Expr left, Expr right): super(left, right, BinaryOperators.OR);

  @override
  Expr get clone => asOr(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitOrExpr(this);
}

OrExpr asOr(Expr e1, Expr e2) => new OrExpr(e1, e2);
