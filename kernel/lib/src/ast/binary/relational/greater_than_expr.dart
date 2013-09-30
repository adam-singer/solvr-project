// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Greater than fx. 3 > 2 */
class GreaterThanExpr extends RelationalExpr {
  GreaterThanExpr(Expr left, Expr right): super(left, right, BinaryOperators.GREATER);

  Expr get clone => greaterThan(left.clone, right.clone);
}

GreaterThanExpr greaterThan(Expr e1, Expr e2) => new GreaterThanExpr(e1, e2);
