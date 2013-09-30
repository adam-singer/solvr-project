// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Reduce powers */
class PowerReducer extends Reducer<PowerExpr> {
  PowerReducer(this._simplifier);

  Expr reduce(PowerExpr expr) {
    // 0^x, 0^1, .. = 0
    if(isZero(baseOf(expr))) {
      return zero;
    }

    // 1^3, 1^X, .. = 1
    if(isOne(baseOf(expr))) {
      return one;
    }

    if(isNumber(exponentOf(expr))) {
      return _reduceNumericalPow(expr);
    }

    return expr;
  }

  Expr _reduceNumericalPow(PowerExpr expr) {
    var orig = expr.toString();

    // 2^3, ...
    if(isNumber(baseOf(expr))) {
      return _simplifier.simplifyNumber(expr);
    }

    // x^0, 42^0 = 1
    if(isZero(exponentOf(expr))) {
      return one;
    }

    // x^1 = x
    if(isOne(exponentOf(expr))) {
      return baseOf(expr);
    }

    var base = baseOf(expr);

    // (x^1/2)^1/2 = x^(1/2 * 1/2) = x^1/4
    if(isPower(base)) {
      var p = exponentOf(base) * exponentOf(expr);
      var exp = _simplifier.simplifyProduct(p);
      var res = power(baseOf(base), exp);

      _logger.debug("converted $orig into $res");
      if(isNumber(res)) {
        return _reduceNumericalPow(res);
      }
      return res;
    }

    // (v1 * v2 * v3)^n = v1^n * v2^n * v3^n
    if(isProduct(base)) {
      base.map((Expr e) => power(e, exponentOf(expr)));
      base.map((Expr e) => isPower(e) ? _reduceNumericalPow(e) : e);

      _logger.debug("converted $orig into $base");
      return _simplifier.simplifyProduct(base);
    }

    return expr;
  }
  
  final AutomaticSimplifier _simplifier;
  static final _logger = LoggerFactory.getLoggerFor(PowerReducer);
}
