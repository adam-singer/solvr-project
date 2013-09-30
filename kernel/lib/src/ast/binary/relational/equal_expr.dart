// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** equals fx. 2 == 2 */
class EqualExpr extends SimpleBinaryExpr {
  EqualExpr(Expr left, Expr right): super(left, right, BinaryOperators.EQUAL);

  Expr get clone => equal(left.clone, right.clone);
}

EqualExpr equal(Expr e1, Expr e2) => new EqualExpr(e1, e2);
