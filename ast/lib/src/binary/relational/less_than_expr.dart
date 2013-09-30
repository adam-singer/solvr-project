// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** less than 2 < 3 */
class LessThanExpr extends RelationalExpr {
  LessThanExpr(Expr left, Expr right): super(left, right, BinaryOperators.LESS);

  @override
  Expr get clone => lessThan(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitLessThanExpr(this);
}

LessThanExpr lessThan(Expr e1, Expr e2) => new LessThanExpr(e1, e2);
