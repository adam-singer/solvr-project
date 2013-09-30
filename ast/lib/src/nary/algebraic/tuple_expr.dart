// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a tuple fx. (), (1), (x^2 + 2x), (1,2,3) */
class TupleExpr extends _ListBasedCollection<Expr> {
  TupleExpr(List<Expr> operands): super(operands, ObjectTypes.TUPLE);

  @override
  asString(StringBuffer buf) => _renderElements(r"(", r",", r")", buf, operands);

  @override
  Expr get clone => tupleOf(_cloneExprList(operands));
  
  @override
  visit(ExprVisitor visitor) => visitor.visitTupleExpr(this);
}

TupleExpr tupleOf(var expr) => (expr is List) ? new TupleExpr(expr) : new TupleExpr([expr]);

