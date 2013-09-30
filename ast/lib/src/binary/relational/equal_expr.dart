// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** equals fx. 2 == 2 */
class EqualExpr extends SimpleBinaryExpr {
  EqualExpr(Expr left, Expr right): super(left, right, BinaryOperators.EQUAL);

  @override
  Expr get clone => equal(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitEqualExpr(this);
}

EqualExpr equal(Expr e1, Expr e2) => new EqualExpr(e1, e2);
