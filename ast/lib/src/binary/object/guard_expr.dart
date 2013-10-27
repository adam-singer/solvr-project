// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Guard (case) expression fx: a | b */
class GuardExpr extends SimpleBinaryExpr {
  GuardExpr(Expr left, Expr right): super(left, right, BinaryOperators.GUARD);

  @override
  Expr get clone => asGuard(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitGuardExpr(this);
}

GuardExpr asGuard(Expr e1, Expr e2) => new GuardExpr(e1, e2);
