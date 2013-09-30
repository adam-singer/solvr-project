// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Union of two sets fx: {1,2,3} union {3,4,5} = {1,2,3,4,5} */
class UnionExpr extends SimpleBinaryExpr {
  UnionExpr(Expr left, Expr right): super(left, right, BinaryOperators.UNION);

  @override
  Expr get clone => union(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitUnionExpr(this);
}

UnionExpr union(Expr e1, Expr e2) => new UnionExpr(e1, e2);
