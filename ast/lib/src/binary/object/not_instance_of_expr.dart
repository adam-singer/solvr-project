// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Test that type is not a instance of another type fx: x is! Number = true */
class NotInstanceOfExpr extends SimpleBinaryExpr {
  NotInstanceOfExpr(Expr left, Expr right): super(left, right, BinaryOperators.NOT_INSTANCE);

  @override
  Expr get clone => notInstanceOf(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitNotInstanceOfExpr(this);
}

NotInstanceOfExpr notInstanceOf(Expr e1, Expr e2) => new NotInstanceOfExpr(e1, e2);
