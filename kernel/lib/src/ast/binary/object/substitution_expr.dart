// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Lambda calculus style substitution of free variable in expression fx: x := y+2 */
class SubstitutionExpr extends SimpleBinaryExpr {
  SubstitutionExpr(Expr left, Expr right): super(left, right, BinaryOperators.SUBSTITUTION);

  Expr get clone => substitution(left.clone, right.clone);
}

SubstitutionExpr substitution(Expr e1, Expr e2) => new SubstitutionExpr(e1, e2);
