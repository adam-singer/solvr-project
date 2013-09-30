// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

/** Algebra functions relating to polynomials */
part of solvr_kernel_math_functions_algebra;

/** Get the coefficient for [variable] with [degree] in [polynomial] */
Expr coefficientOf(Expr polynomial, Expr variable, NumberExpr degree) {
  if(!isSum(polynomial)) {
    // we have a monomial fx 2x^2
    var res = _coefficientMonomial(polynomial, variable);
    var coeffMonomial = res[0];
    var degreeMonomial = res[1];
    if(degreeMonomial == degree) {
      return coeffMonomial;
    }
  } else {
    if(polynomial == variable) {
      // x == x^1
      return (degree == one) ? one : zero;
    }
    var coeffPolynomial = zero;
    // loop through each monomial in the polynomial
    polynomial.operands.forEach((Expr operand) {
      var res = _coefficientMonomial(operand, variable);
      var coeffMonomial = res[0];
      var degreeMonomial = res[1];
      if(degreeMonomial == degree) {
        coeffPolynomial = coeffPolynomial + coeffMonomial;
      }
    });
    return coeffPolynomial;
  }
}

/** Get the degree for [variable] with in [polynomial] */
Expr degreeOf(Expr polynomial, Expr variable) {
  if(polynomial == zero) {
    return minusInfinity;
  } else if(isNumber(polynomial)) {
    return zero;
  } else if(polynomial == variable) {
    return one;
  } else if(polynomial.anyOf([isPower, isProduct])) {
    return _coefficientMonomial(polynomial, variable)[1];
  } else if(isSum(polynomial)) {
    var maxDeg = zero;
    polynomial.operands.forEach((Expr operand) {
      NumberExpr deg = _coefficientMonomial(operand, variable)[1];
      if(maxDeg.numerator < deg.numerator) {
        maxDeg = deg;
      }
    });
    return maxDeg;
  }
  throw new ExprInvocationUndefinedError("no degree for $variable exists in $polynomial");
}

Expr lcf(Expr expr, Expr variable) {
  var degree = degreeOf(expr, variable);
  return coefficientOf(expr, variable, degree);
}

/** Get the list with (coefficient, degree) of [variable] in [monomial] */
List<Expr> _coefficientMonomial(Expr monomial, Expr variable) {
  if(monomial == variable) {
    // coefficient(x^2, x^2) => (coefficient = 1 degree = 1)
    return [one, one];
  } else if(isPower(monomial)) {
    var base = baseOf(monomial);
    var exponent = exponentOf(monomial);
    if(base == variable && isPositiveInteger(exponent)) {
      // coefficient(x^2, x) = (coefficient = 1, degree = 2);
      return [one, exponent];
    }
  } else if(isProduct(monomial)) {
    var deg = zero;
    var coeff = monomial;
    monomial.operands.forEach((Expr operand) {
      // coefficient(x*y^2, y) = coefficient(x, y) -> coefficient(y, y)
      var res = _coefficientMonomial(operand, variable);
      var coeffMonomial = res[0];
      var degreeMonomial = res[1];
      if(degreeMonomial != zero) {
        deg = degreeMonomial;
        coeff = monomial/power(variable, deg);
      }
    });
    return [coeff, deg];
  }

  if(freeOf(monomial, variable)) {
    // coefficient(x^2, z) = (coefficient = x^2, degree = 0)
    return [monomial, zero];
  }
  throw new ExprInvocationUndefinedError("no coefficient for $variable exists in $monomial");
}

/** True if [expr] is a polynomial in one of [variables] */
bool isPolynomial(Expr expr, SetExpr variables) {
  if(!isSum(expr)) {
    return _isMonomial(expr, variables);
  } else {
    if(variables.contains(expr)) {
      return true;
    }
    bool res = true;
    expr.operands.forEach((Expr operand) {
      if(!_isMonomial(operand, variables)) {
        res = false;
        return;
      }
    });
    return res;
  }
}

bool _isMonomial(Expr expr, SetExpr variables) {
  if(variables.contains(expr)) {
    return true;
  } else if(isPower(expr)) {
    var base = baseOf(expr);
    var exponent = exponentOf(expr);
    if(variables.contains(base) && isPositiveInteger(exponent)) {
      return true;
    }
  } else if(isProduct(expr)) {
    bool res = true;
    expr.operands.forEach((Expr operand) {
      if(!_isMonomial(operand, variables)) {
        res = false;
        return;
      }
    });
    return res;
  }
  return setFreeOf(expr, variables);
}

/** Get the variables in a polynomial expression */
SetExpr variablesOf(var expr) {
  if(isNumber(expr)) {
    return emptySet;
  } else if(isPower(expr)) {
    var exponent = exponentOf(expr);
    var base = baseOf(expr);
    if(isPositiveInteger(exponent)) {
      return setOf([base]);
    }
    return setOf([expr]);
  } else if(expr.anyOf([isSum, isProduct])) {
    var res = emptySet;
    expr.operands.forEach((Expr operand) {
      res = res.union(variablesOf(operand));
    });
    return res;
  } else {
    return setOf([expr]);
  }
}




