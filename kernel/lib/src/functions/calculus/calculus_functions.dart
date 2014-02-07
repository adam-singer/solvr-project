// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_functions_calculus;

// TODO http://www.sagemath.org/calctut/index.html
// TODO https://github.com/poeschko/Mathics/blob/master/mathics/builtin/calculus.py

// TODO limit http://www.enotes.com/calculus1/q-and-a/use-stolz-cesaro-theorem-proving-convergence-258630
// http://www.millersville.edu/~bikenaga/calculus/lhopit/lhopit.html
// http://reference.wolfram.com/mathematica/ref/Limit.html

// convergent
// http://tutorial.math.lamar.edu/Classes/CalcII/RatioTest.aspx
// http://www.sosmath.com/calculus/series/rootratio/rootratio.html

// sumOf(x^i/i, i in 1..7)  - TODO render as summation sign
/*
Expr sumOf(Expr expr, List<BindExpr> bindings) {
  return expr;

}
*/

// sumOf(x^i/i, i in 1..7) - TODO render as product sign
/*
Expr productOf(Expr expr, List<BindExpr> bindings) {
  return expr;
}
*/

/**
 * Get the derivative of [expr] with respect to [symbol]
 */
Expr derivative(Expr expr, SymbolExpr symbol) {
  if(expr == symbol) {
    return one;
  } else if(isPower(expr)) {
    // logarithmic differentiation
    var base = baseOf(expr);
    var exp = exponentOf(expr);
    var deriv1 = exp * asPower(base, exp - one) * derivative(base, symbol);
    var deriv2 = derivative(exp,symbol) * expr * ln(base);
    return deriv1 + deriv2;
  } else if(isSum(expr)) {
    // sum rule
    var v = operandOf(expr, 1);
    var w = expr - v;
    var deriv1 = derivative(v, symbol);
    var deriv2 = derivative(w, symbol);
    return deriv1 + deriv2;
  } else if(isProduct(expr)) {
    // product rule
    var v = operandOf(expr, 1);
    var w = expr/v;
    var deriv1 = derivative(v, symbol) * w;
    var deriv2 = derivative(w, symbol) * v;
    return deriv1 + deriv2;
  } else if(isSin(expr)) {
    var arg = operandOf(expr, 1);
    return cos(arg) * derivative(arg, arg);
  } else if(freeOf(expr, symbol)) {
    return zero;
  } else {
    return asInvoke("derivative", asTuple([expr, symbol]));
  }
}
