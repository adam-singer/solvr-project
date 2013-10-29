// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/**
 * Reduce fractions
 */
class FractionReducer extends Reducer<FractionExpr> {
  FractionReducer(this._simplifier); 

  Expr reduce(FractionExpr expr) {
    if(isNumber(expr.left) && isNumber(expr.right)) {
      return _simplifier.simplifyNumber(expr);
    }

    // replace x/y with x*y^-1
    ProductExpr asProduct = expr.left * _simplifier.simplifyPower(invert(expr.right));
    _logger.debug("converting ${expr} into ${asProduct}");
    return _simplifier.simplifyProduct(asProduct);
  }

  static final _logger = LoggerFactory.getLoggerFor(FractionReducer);
  final AutomaticSimplifier _simplifier;
}
