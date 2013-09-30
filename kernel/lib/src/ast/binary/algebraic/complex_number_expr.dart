// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Complex number fx. 3+i4 */
class ComplexNumberExpr extends SimpleBinaryExpr {
  ComplexNumberExpr(Expr left, Expr right): super(left, right, BinaryOperators.COMPLEX);

  Expr get clone => complexNumber(left.clone, right.clone);
}

ComplexNumberExpr complexNumber(Expr e1, Expr e2) => new ComplexNumberExpr(e1, e2);
