// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Greater than fx. 3 > 2 */
class GreaterThanExpr extends RelationalExpr {
  GreaterThanExpr(Expr left, Expr right): super(left, right, BinaryOperators.GREATER);

  @override
  Expr get clone => greaterThan(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitGreaterThanExpr(this);
}

GreaterThanExpr greaterThan(Expr e1, Expr e2) => new GreaterThanExpr(e1, e2);
