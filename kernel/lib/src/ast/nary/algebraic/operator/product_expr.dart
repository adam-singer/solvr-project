// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Product fx. 3*2 */
class ProductExpr extends NaryOperatorExpr {
  ProductExpr(List<Expr> operands): super(operands, NaryOperators.PRODUCT) {
    assert(operands.length > 1);
  }

  asString(StringBuffer buf) {
    if(operands[0].toString() == "-1") {
      // -1 * x * y * .. = -x * y * ...
      buf.write(r"-");
      _renderElements("", r" * ", "", buf, tail(operands));
    } else {
      _renderElements("", r" * ", "", buf, operands);
    }
  }

  Expr get clone => new ProductExpr(_cloneExprList(operands));
}




