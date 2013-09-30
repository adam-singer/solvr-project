// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Not subset operator {3} !subset {1,2,3} = false */
class NotSubsetExpr extends SimpleBinaryExpr {
  NotSubsetExpr(Expr left, Expr right): super(left, right, BinaryOperators.NOT_SUBSET);

  Expr get clone => notSubset(left.clone, right.clone);
}

NotSubsetExpr notSubset(Expr e1, Expr e2) => new NotSubsetExpr(e1, e2);
