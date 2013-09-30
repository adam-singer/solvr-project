// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/**
 * A block expression like
 *
 * {
 *   :
 * }
 */
class BlockExpr extends Expr {
  BlockExpr(this.operands);

  asString(StringBuffer buf) {
    _renderElements("{\n  ", "\n  ", "\n}", buf, operands);
  }

  Expr map(ExprConverter converter) {
    _mapElements(converter, operands, this);
    return this;
  }

  Expr get clone => asBlock(_cloneExprList(operands));

  final IType type = LanguageTypes.BLOCK;
  List<Expr> operands;
}

BlockExpr asBlock(List<Expr> content) => new BlockExpr(content);

