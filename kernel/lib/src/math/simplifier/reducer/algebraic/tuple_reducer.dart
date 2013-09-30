// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Reduce tuple's */
class TupleReducer extends Reducer<TupleExpr> {
  TupleReducer(this._simplifier);

  Expr reduce(TupleExpr expr) {
    if(expr.length == 1) {
      var elm = expr[0];

      // TODO a better rule to implement here would be to check if the expression in the parentheses
      // has a higher or equal precedense than its parent, if so then just remove the grouping
      // - for this to work we should ensure that expr contructor expressions always adds precedense
      // - (currently only the parser knows the actual precedence number).

      // remove parentheses when possible
      if(expr.parent == null) {
        // (x+1) = x+1,
        return elm;
      } else if(expr.parentsAre([isAlgebraicCollection])) {
        // {(1+x), (3+y)} = {1+x,3+y}
        return elm;
      } else if(expr.parent.type == elm.type) {
        // a+(b+c) = a+b+c, a*(b*c) = a*b*c
        return elm;
      } else if(elm.anyOf([isFactorial, isInvoke, isLexical, isProduct, isPower])) {
        // (n!) = n!, (f(x)) = f(x), ...
        return elm;
      }
    }

    // TODO handle other tuple operations (existence, multiplication, ...)

    return expr;
  }
  
  final AutomaticSimplifier _simplifier;
}
