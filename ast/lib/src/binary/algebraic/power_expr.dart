// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Power fx. 3^2 */
class PowerExpr extends BinaryExpr {
  PowerExpr(Expr left, Expr right): super(left, right, BinaryOperators.POWER);

  @override
  Expr get clone => asPower(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitPowerExpr(this);
}

PowerExpr asPower(Expr left, Expr right) => new PowerExpr(left, right);

