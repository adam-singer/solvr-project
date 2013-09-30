// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Guard (case) expression fx: a | b */
class GuardExpr extends SimpleBinaryExpr {
  GuardExpr(Expr left, Expr right): super(left, right, BinaryOperators.GUARD);

  Expr get clone => guard(left.clone, right.clone);
}

GuardExpr guard(Expr e1, Expr e2) => new GuardExpr(e1, e2);
