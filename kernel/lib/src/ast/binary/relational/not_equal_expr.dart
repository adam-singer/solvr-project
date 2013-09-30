// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Not equals fx. 3 != 4 */
class NotEqualExpr extends SimpleBinaryExpr {
  NotEqualExpr(Expr left, Expr right): super(left, right, BinaryOperators.NOT_EQUAL);

  Expr get clone => notEqual(left.clone, right.clone);
}

NotEqualExpr notEqual(Expr e1, Expr e2) => new NotEqualExpr(e1, e2);
