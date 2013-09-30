// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Power fx. 3^2 */
class PowerExpr extends BinaryExpr {
  PowerExpr(Expr left, Expr right): super(left, right, BinaryOperators.POWER);

  asString(StringBuffer buf) {
    left.asString(buf);
    buf.write("$token");
    right.asString(buf);
  }

  Expr get clone => power(left.clone, right.clone);
}

PowerExpr power(var b, var e) => new PowerExpr(b, e);

