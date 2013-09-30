// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Type/value pair fx: "String value" or "List<Symbol> symbols" */
class TypedExpr extends Expr {
  TypedExpr(this.key, this.value);

  asString(StringBuffer buf) {
    key.asString(buf);
    buf.write(r" ");
    value.asString(buf);
  }

  Expr map(ExprConverter converter) {
    converter(key);
    key.parent = this;
    converter(value);
    value.parent = this;
    return this;
  }

  List<Expr> get operands => [ key, value ];

  Expr get clone => asTyped(key.clone, value.clone);

  final IType type = LanguageTypes.TYPED;
  Expr key, value;
}

TypedExpr asTyped(Expr type, Expr value) => new TypedExpr(type, value);
