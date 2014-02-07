// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_kernel_math_functions_calculus;

/**
 * Solve differential [equation] that can be transformed to the form: M(x,y) + N(x,y) d(y,x) = 0,
 *
 * For example the differential equation: 2x + 3y^2 + (6xy + y^2) d(y,x) can be solved by using
 * - M(x,y) = 2x + 3y^2
 * - N(x,y) = 6xy + y^2
 *
 * 1) Integrate M with respect to x: integrate(2x + 3y^2, x) = x^2 + 3xy^2 + h(y)
 * 2) Differentiate 1 with respect to y: differentiate(x^2 + 3xy^2 + h(y), y) = 6xy + h'(y)
 * 3) Compare 2 to N to obtain: 6xy + h'(y) = 6xy + y^2 implying h'(y) = y^2
 * 4) Integration 3 with respect to y obtain: h(y) = y^3/3
 * 5) The solution is therefore: g(x,y) = x^2 + 3xy^2 +y^3/3
 */
Expr solveOde(Expr equation, SymbolExpr x, SymbolExpr y) {
  List<Expr> parts = _transformOde(equation, x, y);
  var m = parts[0];
  var n = parts[1];
  Expr solution;
  try {
    solution = _separableOde(m, n, x, y);
  } catch(e) {
    solution = _solveExact(m, n, x, y);
  }
  return solution;
}

List<Expr> _transformOde(Expr equation, SymbolExpr x, SymbolExpr y) {
  var diff = operandOf(equation, 1) - operandOf(equation, 2);
  var expr = normal(diff);
  var dividend = numeratorOf(expr);
  var m = coefficientOf(dividend, _d(y,x), zero);
  var n = coefficientOf(dividend, _d(y,x), one);
  return [m,n];
}

Expr _separableOde(Expr m, Expr n, Expr x, Expr y) {
  throw "TODO separableOde";
}

Expr _solveExact(Expr m, Expr n, Expr x, Expr y) {
  throw "TODO solveExact";
}

Expr _d(Expr x, Expr y) {
  throw "TODO d";
}

