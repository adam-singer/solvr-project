// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

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


