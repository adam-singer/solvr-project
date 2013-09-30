// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Test that type is a instance of another type fx: (x is Symbol) = true */
class InstanceOfExpr extends SimpleBinaryExpr {
  InstanceOfExpr(Expr left, Expr right): super(left, right, BinaryOperators.INSTANCE);

  @override
  Expr get clone => instanceOf(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitInstanceOfExpr(this);
}

InstanceOfExpr instanceOf(Expr e1, Expr e2) => new InstanceOfExpr(e1, e2);
