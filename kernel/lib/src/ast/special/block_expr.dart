// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

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

