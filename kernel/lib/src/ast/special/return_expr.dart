// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** A return statement */
class ReturnExpr extends Expr {
  ReturnExpr(this.value);

  asString(StringBuffer buf) {
    buf.write("return ");
    value.asString(buf);
  }

  Expr map(ExprConverter converter) {
    converter(value);
    value.parent = this;
    return this;
  }

  List<Expr> get operands => [ value ];

  Expr get clone => asReturn(value.clone);

  final IType type = LanguageTypes.RETURN;
  Expr value;
}

ReturnExpr asReturn(Expr value) => new ReturnExpr(value);
