// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** negative expressions fx. -1 or -x */
class NegativeExpr extends UnaryExpr {
  NegativeExpr(Expr operand): super(operand, UnaryOperators.NEGATIVE);

  asString(StringBuffer buf) {
    buf.write(token);
    operand.asString(buf);
  }

  Expr get clone => negative(operand.clone);
}

NegativeExpr negative(var expr) => new NegativeExpr(expr);
