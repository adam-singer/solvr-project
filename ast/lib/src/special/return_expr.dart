// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

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
