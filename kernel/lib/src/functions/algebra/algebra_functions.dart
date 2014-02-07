// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_functions_algebra;

/*
 * General purpose algebra functions
 */

/**
 * Get the denominator of a algebraic expression
 */
Expr denominatorOf(var expr) {
  return _numeratorDenominator(expr)[1];
}

/**
 * Expand a algebraic expression
 */
Expr expand(var expr) {
  if(isSum(expr)) {
    var operands = _expandOperands(expr);
    var first = operands[0];
    var rest = sumOf(tail(operands));
    return expand(first) + expand(rest);
  } else if(isProduct(expr)) {
    var operands = _expandOperands(expr);
    var first = operands[0];
    var rest = productOf(tail(operands));
    return _expandProduct(expand(first), expand(rest));
  } else if(isPower(expr)) {
    var base = _expandTuple(baseOf(expr));
    var exponent = _expandTuple(exponentOf(expr));
    if(isPower(base)) {
      var b = _expandTuple(baseOf(base));
      var e = _expandTuple(exponentOf(base));
      return expand(asPower(b, e*exponent));
    }
    // x^2, x^3....
    return _expandPower(expand(base), exponent);
  }
  return expr;
}

/*
 * Return the expanded form of [expr1] * [expr2]
 */
Expr _expandProduct(Expr expr1, Expr expr2) {
  if(isSum(expr1)) {
    var operands = _expandOperands(expr1);
    var first = operands[0];
    var rest = sumOf(tail(operands));
    return _expandProduct(first, expr2) + _expandProduct(rest, expr2);
  } else if(isSum(expr2)) {
    return _expandProduct(expr2, expr1);
  } else {
    return expr1 * expr2;
  }
}

/*
 * Return the expanded form of [base]^[exponent]
 */
Expr _expandPower(Expr base, Expr exponent) {
  if(isSum(base) || isSum(exponent)) {
    var result = null;
    if(isSum(base)) {
      // (a+b)^2 = (a+b)(a+b)....
      if(isPositiveInteger(exponent)) {
        var operands = _expandOperands(base);
        var first = operands[0];
        var rest = sumOf(tail(operands));
        NumberExpr n = exponent;

        var index = Integer.zero;
        while(index < n.numerator) {
          index = index.increment;
          if(result == null) {
            result = base;
          } else {
            result *= base;
          }
        }
        result = expand(result);
      }
    }

    if(isSum(exponent)) {
      // (a+b)^(2+n) = (a+b)^2 * (a+b)^n
      var operands = _expandOperands(exponent);
      base = isNullary(base) ? base : asTuple(base);
      operands.forEach((Expr operand) {
        var tmp = asPower(base, expand(operand));
        if(result == null) {
          result = tmp;
        } else {
          result *= tmp;
        }
      });
      // ensure automatic simplification does not undo the expansion
      result.reduced = true;
    }
    return result;
  } else {
    return asPower(base, exponent);
  }
}

List<Expr> _expandOperands(var expr) {
  var operands = expr.operands.map(_expandTuple);
  return operands;
}

Expr _expandTuple(var expr) {
  if(isTuple(expr) && expr.length == 1) {
    return expr[0];
  }
  return expr;
}

/**
 * Collect like terms in a algebraic expression
 */
Expr collect(var expr) {
  // TODO p. 250
}

/**
 * Put a expression on normal form (rational simplify)
 */
Expr normal(var expr) {
  return expr;
}

/**
 * Get the numerator of a algebraic expression
 */
Expr numeratorOf(var expr) => _numeratorDenominator(expr)[0];

List<Expr> _numeratorDenominator(var expr) {
  if(isFraction(expr)) {
    return [expr.left, expr.right];
  } else if(isPower(expr)) {
    var exponent = _expandTuple(exponentOf(expr));
    var base = _expandTuple(baseOf(expr));
    // e^-x => 1/e^x => numerator = 1 and denominator = e^x
    if(isNegativeExpr(exponent)) {
      return [one, invert(expr)];
    } else if(isSum(exponent)) {
      // x^(a + b - c) = x^a * x^b * x^-c so numerator is x^a * x^b and denominator is x^c
      List<Expr> operands = exponent.operands;
      List<Expr> negated = operands.where(isNegativeExpr).map(negative);
      List<Expr> positives = operands.where(isPositiveExpr);
      var numerator = positives.isEmpty ? one : asPower(base, sumOf(positives));
      var denominator = negated.isEmpty ? one : asPower(base, sumOf(negated));
      return [numerator, denominator];
    }
  } else if(isProduct(expr)) {
    // a * b * c => numerator = numerator(a) * numerator((a * b * c)/a)....
    var first = expr.operands[0];
    var rest = simplify(expr/first);
    var numerator = numeratorOf(first) * numeratorOf(rest);
    var denominator = denominatorOf(first) * denominatorOf(rest);
    return [numerator, denominator];
  }
  return [expr, one];
}

/** Convert list of expressions into a single expression */
Expr construct(List<Expr> list, Expr constructor(Expr e1, Expr e2)) {
  return tail(list).fold(list[0], constructor);
}
