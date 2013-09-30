// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/**
 * Set complement (usually A \ B)
 *
 * Fx:
 * - A = {a,b,c}
 * - B = {b,c,d}
 * - A \ B = { x | x in A && x notIn B } = {a}
 */
class ComplementExpr extends SimpleBinaryExpr {
  ComplementExpr(Expr left, Expr right): super(left, right, BinaryOperators.COMPLEMENT);

  Expr get clone => complement(left.clone, right.clone);
}

ComplementExpr complement(Expr e1, Expr e2) => new ComplementExpr(e1, e2);
