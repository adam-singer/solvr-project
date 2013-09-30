// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** less than or equal 2 <= 2 */
class LessThanOrEqualExpr extends RelationalExpr {
  LessThanOrEqualExpr(Expr left, Expr right): super(left, right, BinaryOperators.LESS_OR_EQUAL);

  Expr get clone => lessThanOrEqual(left.clone, right.clone);
}

LessThanOrEqualExpr lessThanOrEqual(Expr e1, Expr e2) => new LessThanOrEqualExpr(e1, e2);
