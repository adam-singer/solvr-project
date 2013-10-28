// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** less than or equal 2 <= 2 */
class LessThanOrEqualExpr extends RelationalExpr {
  LessThanOrEqualExpr(Expr left, Expr right): super(left, right, BinaryOperators.LESS_OR_EQUAL);

  @override
  Expr get clone => asLessThanOrEqual(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitLessThanOrEqualExpr(this);
}

LessThanOrEqualExpr asLessThanOrEqual(Expr e1, Expr e2) => new LessThanOrEqualExpr(e1, e2);
