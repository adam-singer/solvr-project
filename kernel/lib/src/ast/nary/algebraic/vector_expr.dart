// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a list fx. {1,2,3} */
class VectorExpr extends _ListBasedCollection<Expr> {
  VectorExpr(List<Expr> operands): super(operands, ObjectTypes.VECTOR);

  asString(StringBuffer buf) => _renderElements(r"[", r"; ", r"]", buf, operands);

  Expr get clone => vectorOf(_cloneExprList(operands));
}

VectorExpr vectorOf(List<Expr> elements) => new VectorExpr(elements);
