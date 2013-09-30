// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a string fx: "word" */
class StringExpr extends NullaryExpr<String> {
  StringExpr(String value): this._internal('\"${value}\"');

  StringExpr._internal(String value): super(value, ObjectTypes.STRING);

  @override
  Expr get clone => new StringExpr._internal(value);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitStringExpr(this);
}

StringExpr stringOf(String value) => new StringExpr(value);

