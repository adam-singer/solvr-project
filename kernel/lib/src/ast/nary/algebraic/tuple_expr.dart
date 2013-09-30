// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a tuple fx. (), (1), (x^2 + 2x), (1,2,3) */
class TupleExpr extends _ListBasedCollection<Expr> {
  TupleExpr(List<Expr> operands): super(operands, ObjectTypes.TUPLE);

  asString(StringBuffer buf) => _renderElements(r"(", r",", r")", buf, operands);

  Expr get clone => tupleOf(_cloneExprList(operands));
}

TupleExpr tupleOf(var expr) => (expr is List) ? new TupleExpr(expr) : new TupleExpr([expr]);

