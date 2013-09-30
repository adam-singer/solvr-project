// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/**
 * Represents a conditional expression like
 *
 * if(x > 2) {
 *   :
 * }
 */
class ConditionalExpr extends Expr {
  ConditionalExpr(this.condition, this.ifBody, this.elsePart);

  asString(StringBuffer buf) {
    buf.write("if");
    condition.asString(buf);
    ifBody.asString(buf);
    if(elsePart is! NothingExpr) {
      buf.write("else");
      elsePart.asString(buf);
    }
  }

  Expr map(ExprConverter converter) {
    _mapElements(converter, operands, this);
    return this;
  }

  List<Expr> get operands => [ condition, ifBody, elsePart ];

  Expr get clone => asConditional(condition.clone, ifBody.clone, elsePart.clone);

  final IType type = LanguageTypes.CONDITIONAL;
  Expr condition, ifBody, elsePart;
}

ConditionalExpr asConditional(Expr condition, Expr ifBody, Expr elsePart) => new ConditionalExpr(condition, ifBody, elsePart);
