// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Logical complement (negation) fx. !true = false */
class NegationExpr extends UnaryExpr {
  NegationExpr(Expr operand): super(operand, UnaryOperators.NEGATION);

  asString(StringBuffer buf) {
    buf.write(token);
    operand.asString(buf);
  }

  Expr get clone => negation(operand.clone);
}

NegationExpr negation(var expr) => new NegationExpr(expr);
