// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a list fx. [1,2,3] */
class ListExpr extends _ListBasedCollection<Expr> {
  ListExpr(List<Expr> operands): super(operands, ObjectTypes.LIST);

  @override
  asString(StringBuffer buf) => _renderElements(r"[", r",", r"]", buf, operands);

  @override
  Expr get clone => listOf(_cloneExprList(operands));
  
  @override
  visit(ExprVisitor visitor) => visitor.visitListExpr(this);
}

ListExpr listOf(List<Expr> elements) => new ListExpr(elements);
