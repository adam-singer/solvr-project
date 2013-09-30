// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** less than 2 < 3 */
class LessThanExpr extends RelationalExpr {
  LessThanExpr(Expr left, Expr right): super(left, right, BinaryOperators.LESS);

  Expr get clone => lessThan(left.clone, right.clone);
}

LessThanExpr lessThan(Expr e1, Expr e2) => new LessThanExpr(e1, e2);
