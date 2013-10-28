// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Product fx. 3*2 */
class ProductExpr extends NaryOperatorExpr {
  ProductExpr(List<Expr> operands): super(operands, NaryOperators.PRODUCT) {
    assert(operands.length > 1);
  }

  @override
  Expr get clone => new ProductExpr(_cloneExprList(operands));
  
  @override
  visit(ExprVisitor visitor) => visitor.visitProductExpr(this);
}

ProductExpr asProduct(List<Expr> operands) => new ProductExpr(operands);




