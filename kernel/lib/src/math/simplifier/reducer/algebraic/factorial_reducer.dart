// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/**
 * Reduce factorials
 */
class FactorialReducer extends Reducer<FactorialExpr> {
  FactorialReducer(this._simplifier);

  Expr reduce(FactorialExpr expr) {
    if(isNumber(expr.operand)) {
      return _simplifier.simplifyNumber(expr);
    } else if(isAlgebraicCollection(expr)) {
      throw new KernelError("TODO map factorial accross all elements");
    }
    return expr;
  }
  
  final AutomaticSimplifier _simplifier;
}
