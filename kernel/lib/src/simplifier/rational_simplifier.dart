// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/**
 * Transform an algebraic expression to a rational expression with
 * no common factores in the numerator and denominator
 */
class RationalSimplifier {
  static RationalSimplifier _instance;

  factory RationalSimplifier() {
    if(_instance == null) {
      _instance = new RationalSimplifier._internal();
    }
    return _instance;
  }

  factory RationalSimplifier._internal() {
    throw "TODO _rationalSimplify";
  }

  Expr simplify(Expr expr) => null;
}

