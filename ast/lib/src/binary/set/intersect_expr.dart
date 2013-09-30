// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Intersection of two sets fx: {1,2,3} intersect {3,4,5} = {1,2,3,4,5} */
class IntersectExpr extends SimpleBinaryExpr {
  IntersectExpr(Expr left, Expr right): super(left, right, BinaryOperators.INTERSECT);

  @override
  Expr get clone => intersect(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitIntersectExpr(this);
}

IntersectExpr intersect(Expr e1, Expr e2) => new IntersectExpr(e1, e2);
