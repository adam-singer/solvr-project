// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** subset operator {3} subset {1,2,3} = true */
class SubsetExpr extends BinaryExpr {
  SubsetExpr(Expr left, Expr right): super(left, right, BinaryOperators.SUBSET);

  @override
  Expr get clone => asSubset(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitSubsetExpr(this);
}

SubsetExpr asSubset(Expr e1, Expr e2) => new SubsetExpr(e1, e2);
