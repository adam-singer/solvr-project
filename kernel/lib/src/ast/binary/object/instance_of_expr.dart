// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Test that type is a instance of another type fx: (x is Symbol) = true */
class InstanceOfExpr extends SimpleBinaryExpr {
  InstanceOfExpr(Expr left, Expr right): super(left, right, BinaryOperators.INSTANCE);

  Expr get clone => instanceOf(left.clone, right.clone);
}

InstanceOfExpr instanceOf(Expr e1, Expr e2) => new InstanceOfExpr(e1, e2);
