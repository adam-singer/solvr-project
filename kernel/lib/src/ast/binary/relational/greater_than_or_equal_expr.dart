// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** greater than or equal fx. 3 >= 2 */
class GreaterThanOrEqualExpr extends RelationalExpr {
  GreaterThanOrEqualExpr(Expr left, Expr right): super(left, right, BinaryOperators.GREATER_OR_EQUAL);

  Expr get clone => greaterThanOrEqual(left.clone, right.clone);
}

GreaterThanOrEqualExpr greaterThanOrEqual(Expr e1, Expr e2) => new GreaterThanOrEqualExpr(e1, e2);
