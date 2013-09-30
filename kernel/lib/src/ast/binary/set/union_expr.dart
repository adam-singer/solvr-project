// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Union of two sets fx: {1,2,3} union {3,4,5} = {1,2,3,4,5} */
class UnionExpr extends SimpleBinaryExpr {
  UnionExpr(Expr left, Expr right): super(left, right, BinaryOperators.UNION);

  Expr get clone => union(left.clone, right.clone);
}

UnionExpr union(Expr e1, Expr e2) => new UnionExpr(e1, e2);
