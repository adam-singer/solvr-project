// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Sum fx. 3+2 */
class SumExpr extends NaryOperatorExpr {
  SumExpr(List<Expr> operands): super(operands, NaryOperators.SUM) {
    assert(operands.length > 1);
  }

  asString(StringBuffer buf) => _renderElements("", r" + ", "", buf, operands);

  Expr get clone => new SumExpr(_cloneExprList(operands));
}

