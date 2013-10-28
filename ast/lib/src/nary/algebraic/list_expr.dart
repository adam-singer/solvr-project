// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a list fx. [1,2,3] */
class ListExpr extends _ListBasedCollection<Expr> {
  ListExpr(List<Expr> operands): super(operands, ObjectTypes.LIST);

  @override
  Expr get clone => asList(_cloneExprList(operands));
  
  @override
  visit(ExprVisitor visitor) => visitor.visitListExpr(this);
}

ListExpr asList(List<Expr> elements) => new ListExpr(elements);
