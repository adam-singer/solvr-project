// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a symbol literal fx: x in x^2 + 2 (assuming x is not a bound variable) */
class SymbolExpr extends NullaryExpr<String> {
  SymbolExpr(String value): super(value, ObjectTypes.SYMBOL);

  Expr get clone => asSymbol(value);
}

SymbolExpr asSymbol(String value) => new SymbolExpr(value);

