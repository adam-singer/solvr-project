// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a vector fx. [1;2;3] */
class VectorExpr extends _ListBasedCollection<Expr> {
  VectorExpr(List<Expr> operands): super(operands, ObjectTypes.VECTOR);

  @override
  asString(StringBuffer buf) => _renderElements(r"[", r"; ", r"]", buf, operands);

  @override
  Expr get clone => asVector(_cloneExprList(operands));
  
  @override
  visit(ExprVisitor visitor) => visitor.visitVectorExpr(this);
}

VectorExpr asVector(List<Expr> elements) => new VectorExpr(elements);
