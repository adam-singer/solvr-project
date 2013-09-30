// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Factorial fx. 3! */
class FactorialExpr extends UnaryExpr {
  FactorialExpr(Expr operand): super(operand, UnaryOperators.FACTORIAL);

  asString(StringBuffer buf) {
    operand.asString(buf);
    buf.write(token);
  }

  Expr get clone => factorial(operand.clone);
}

FactorialExpr factorial(var expr) => new FactorialExpr(expr);
