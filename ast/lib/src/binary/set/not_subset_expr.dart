// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Not subset operator {3} !subset {1,2,3} = false */
class NotSubsetExpr extends SimpleBinaryExpr {
  NotSubsetExpr(Expr left, Expr right): super(left, right, BinaryOperators.NOT_SUBSET);

  @override
  Expr get clone => asNotSubset(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitNotSubsetExpr(this);
}

NotSubsetExpr asNotSubset(Expr e1, Expr e2) => new NotSubsetExpr(e1, e2);
