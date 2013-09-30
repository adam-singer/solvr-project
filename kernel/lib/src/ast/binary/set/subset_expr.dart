// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** subset operator {3} subset {1,2,3} = true */
class SubsetExpr extends SimpleBinaryExpr {
  SubsetExpr(Expr left, Expr right): super(left, right, BinaryOperators.SUBSET);

  Expr get clone => subset(left.clone, right.clone);
}

SubsetExpr subset(Expr e1, Expr e2) => new SubsetExpr(e1, e2);
