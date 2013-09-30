// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Intersection of two sets fx: {1,2,3} intersect {3,4,5} = {1,2,3,4,5} */
class IntersectExpr extends SimpleBinaryExpr {
  IntersectExpr(Expr left, Expr right): super(left, right, BinaryOperators.INTERSECT);

  Expr get clone => intersect(left.clone, right.clone);
}

IntersectExpr intersect(Expr e1, Expr e2) => new IntersectExpr(e1, e2);
