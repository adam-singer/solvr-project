// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/**
 * Logical conjunction (/\) fx: a and b
 */
class AndExpr extends SimpleBinaryExpr {
  AndExpr(Expr left, Expr right): super(left, right, BinaryOperators.AND);

  Expr get clone => and(left.clone, right.clone);
}

AndExpr and(Expr e1, Expr e2) => new AndExpr(e1, e2);
