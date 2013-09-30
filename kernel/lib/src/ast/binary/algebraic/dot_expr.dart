// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Dot product such as  {1,2,3} . {2,4,6} */
class DotExpr extends SimpleBinaryExpr {
  DotExpr(Expr left, Expr right): super(left, right, BinaryOperators.DOT, "");

  Expr get clone => dot(left.clone, right.clone);
}

DotExpr dot(Expr e1, Expr e2) => new DotExpr(e1, e2);
