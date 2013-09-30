// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** reduce subtraction (difference) expressions */
class DifferenceReducer extends Reducer<Expr> {
  DifferenceReducer(this._simplifier);

  Expr reduce(var expr) {
    if(isDifference(expr)) {
      if(isNumber(expr.left) && isNumber(expr.right)) {
        return _simplifier.simplifyNumber(expr);
      }
      // replace "x - y" with "x + (-1 * y)"
      Expr asSum = expr.left + _negate(expr.right);
      _logger.debug("converting ${expr} into ${asSum}");

      return _simplifier.simplifySum(asSum);
    }

    if(isNegative(expr)) {
      // replace "-expr" with "-1 * expr"
      var negated = _negate(expr.operand);
      _logger.debug("converting ${expr} into -1 * ${expr.operand}");
      return negated;
    }

    throw new ExprUnhandledError.expr(expr);
  }

  Expr _negate(Expr expr) {
    if(isNumber(expr)) {
      var num = expr as NumberExpr;
      // -0 = 0
      return isZero(num) ? expr : ~num;
    }
    return minusOne * expr;
  }

  final AutomaticSimplifier _simplifier;
  static final _logger = LoggerFactory.getLoggerFor(DifferenceReducer);
}
