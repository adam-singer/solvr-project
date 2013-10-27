// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Logical conjunction (/\) fx: a and b */
class AndExpr extends SimpleBinaryExpr {
  AndExpr(Expr left, Expr right): super(left, right, BinaryOperators.AND);

  @override
  Expr get clone => asAnd(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitAndExpr(this);
}

AndExpr asAnd(Expr e1, Expr e2) => new AndExpr(e1, e2);
