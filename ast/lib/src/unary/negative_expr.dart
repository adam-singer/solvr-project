// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

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
