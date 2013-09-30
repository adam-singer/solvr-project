// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Logical disjunction (\/) fx: a or b */
class OrExpr extends SimpleBinaryExpr {
  OrExpr(Expr left, Expr right): super(left, right, BinaryOperators.OR);

  Expr get clone => or(left.clone, right.clone);
}

OrExpr or(Expr e1, Expr e2) => new OrExpr(e1, e2);
