// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Binding fx: x in 1..10 */
class BindExpr extends SimpleBinaryExpr {
  BindExpr(Expr left, Expr right): super(left, right, BinaryOperators.BIND);

  Expr get clone => bind(left.clone, right.clone);
}

BindExpr bind(Expr e1, Expr e2) => new BindExpr(e1, e2);
