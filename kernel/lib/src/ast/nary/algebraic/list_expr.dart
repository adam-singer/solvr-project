// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a list fx. [1,2,3] */
class ListExpr extends _ListBasedCollection<Expr> {
  ListExpr(List<Expr> operands): super(operands, ObjectTypes.LIST);

  asString(StringBuffer buf) => _renderElements(r"[", r",", r"]", buf, operands);

  Expr get clone => listOf(_cloneExprList(operands));
}

ListExpr listOf(List<Expr> elements) => new ListExpr(elements);
