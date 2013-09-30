// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Difference fx. 3-2 */
class DifferenceExpr extends SimpleBinaryExpr {
  DifferenceExpr(Expr left, Expr right): super(left, right, BinaryOperators.DIFFERENCE);

  Expr get clone => left.clone - right.clone;
}



