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
class ConditionalExpr extends SpecialExpr {
  ConditionalExpr(this.condition, this.ifBody, this.elsePart) {
    // TODO set parent
  }

  @override
  Expr map(ExprConverter converter) {
    _mapElements(converter, operands, this);
    return this;
  }

  @override
  List<Expr> get operands => [ condition, ifBody, elsePart ];

  @override
  Expr get clone => asConditional(condition.clone, ifBody.clone, elsePart.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitConditionalExpr(this);

  @override
  final IType type = LanguageTypes.CONDITIONAL;
  
  Expr condition, ifBody, elsePart;
}

ConditionalExpr asConditional(Expr condition, Expr ifBody, Expr elsePart) => new ConditionalExpr(condition, ifBody, elsePart);
