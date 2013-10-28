// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Not equals fx. 3 != 4 */
class NotEqualExpr extends SimpleBinaryExpr {
  NotEqualExpr(Expr left, Expr right): super(left, right, BinaryOperators.NOT_EQUAL);

  @override
  Expr get clone => asNotEqual(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitNotEqualExpr(this);
}

NotEqualExpr asNotEqual(Expr e1, Expr e2) => new NotEqualExpr(e1, e2);
