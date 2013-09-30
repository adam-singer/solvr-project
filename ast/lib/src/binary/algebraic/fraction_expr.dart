// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Fractions fx. (x+1)/5 or 1/2 */
class FractionExpr extends BinaryExpr {
  FractionExpr(Expr left, Expr right): super(left, right, BinaryOperators.FRACTION);

  asString(StringBuffer buf) {
    left.asString(buf);
    buf.write("$token");
    right.asString(buf);
  }

  Expr get clone => (left.clone)/(right.clone);
}

