// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Test that type is not a instance of another type fx: x is! Number = true */
class NotInstanceOfExpr extends SimpleBinaryExpr {
  NotInstanceOfExpr(Expr left, Expr right): super(left, right, BinaryOperators.NOT_INSTANCE);

  Expr get clone => notInstanceOf(left.clone, right.clone);
}

NotInstanceOfExpr notInstanceOf(Expr e1, Expr e2) => new NotInstanceOfExpr(e1, e2);
