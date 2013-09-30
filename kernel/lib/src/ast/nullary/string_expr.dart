// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a string fx: "word" */
class StringExpr extends NullaryExpr<String> {
  StringExpr(String value): this._internal('\"${value}\"');

  StringExpr._internal(String value): super(value, ObjectTypes.STRING);

  Expr get clone => new StringExpr._internal(value);
}

StringExpr stringOf(String value) => new StringExpr(value);

