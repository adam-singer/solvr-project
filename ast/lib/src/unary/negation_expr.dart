// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

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
