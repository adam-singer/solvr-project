// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

class DotReducer extends Reducer<DotExpr> {
  DotReducer(this._simplifier);

  Expr reduce(DotExpr expr) {
    var op1 = expr.left;
    var op2 = expr.right;
    var operands = expr.operands;

    if(operands.every(isVector)) {
      return _vectorDotProduct(op1, op2);
    } else if(operands.every(isMatrix)) {
      return _matrixDotProduct(op1, op2);
    }

    throw new ExprUnhandledError.expr(expr);
  }

  Expr _vectorDotProduct(VectorExpr v1, VectorExpr v2) {
    if(v1.length == v2.length) {
      // [a b c] . [d e f]", "a*d + b*e + c*f
      var multiplied = v1.mapThisI((Expr operand, int i) => _simplifier.simplifyProduct(operand * v2[i]));
      var dotProduct = _simplifier.simplifySum(sumOf(multiplied.operands));
      return dotProduct;
    }
  }

  Expr _matrixDotProduct(MatrixExpr m1, MatrixExpr m2) {

  }

  final AutomaticSimplifier _simplifier;
  static final _logger = LoggerFactory.getLoggerFor(DotReducer);
}
