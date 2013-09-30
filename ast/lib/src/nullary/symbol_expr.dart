// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a symbol literal fx: x in x^2 + 2 (assuming x is not a bound variable) */
class SymbolExpr extends NullaryExpr<String> {
  SymbolExpr(String value): super(value, ObjectTypes.SYMBOL);

  @override
  Expr get clone => asSymbol(value);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitSymbolExpr(this);
}

SymbolExpr asSymbol(String value) => new SymbolExpr(value);

