// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

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




