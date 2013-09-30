// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a list fx. {1,2,3} */
class VectorExpr extends _ListBasedCollection<Expr> {
  VectorExpr(List<Expr> operands): super(operands, ObjectTypes.VECTOR);

  asString(StringBuffer buf) => _renderElements(r"[", r"; ", r"]", buf, operands);

  Expr get clone => vectorOf(_cloneExprList(operands));
}

VectorExpr vectorOf(List<Expr> elements) => new VectorExpr(elements);
