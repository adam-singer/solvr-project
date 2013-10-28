// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Type/value pair fx: "String value" or "List<Symbol> symbols" */
class TypedExpr extends Expr {
  TypedExpr(this.key, this.value);

  @override
  Expr map(ExprConverter converter) {
    converter(key);
    key.parent = this;
    converter(value);
    value.parent = this;
    return this;
  }

  @override
  List<Expr> get operands => [ key, value ];

  @override
  Expr get clone => asTyped(key.clone, value.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitTypedExpr(this);

  @override
  final IType type = LanguageTypes.TYPED;
  
  Expr key, value;
}

TypedExpr asTyped(Expr type, Expr value) => new TypedExpr(type, value);
