// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Reduce numerical expressions */
class NumberReducer extends Reducer<Expr> {
  Expr reduce(Expr expr) {
    var res = _reduceRationalNumber(expr).reducedForm;
    if(expr is NumberExpr) {
      var numberExpr = expr as NumberExpr;
      // TODO should decimals really be handled here ? - if so find a much better solution
      if(numberExpr.isReal && !res.isInteger) {
        String value = numberExpr.value;
        return new NumberExpr.realFromRational(res.numerator, res.denominator, value);
      }
    } 
    return new NumberExpr(res.numerator, res.denominator);
  }

  RationalNumber _reduceRationalNumber(Expr expr) {
    RationalNumber res;
    if(expr is NumberExpr) {
      res = valueOf(expr);
    } else if(isUnary(expr)) {
      var n = valueOf((expr as UnaryExpr).operand);
      if(isNegative(expr)) {
        res = ~n;
      } else if(isFactorial(expr)) {
        res = n.fact;
      } else {
        throw new ExprUnhandledError("unhandled unary number expression $expr", expr);
      }
    } else if(isBinary(expr)) {
      var n1 = valueOf((expr as BinaryExpr).left);
      var n2 = valueOf((expr as BinaryExpr).right);
      if(isDifference(expr)) {
        res = n1 - n2;
      } else if(isFraction(expr)) {
        res = n1/n2;
      } else if(isPower(expr)) {
        res = n1.pow(n2);
      } else {
        throw new ExprUnhandledError("unhandled binary number expression $expr", expr);
      }
    } else if(isNaryOperator(expr)) {
      var operands = expr.operands.map(valueOf);
      if(isSum(expr)) {
        res = operands.fold(RationalNumber.zero, (e1,e2) => e1 + e2);
      } else if(isProduct(expr)) {
        res = operands.fold(RationalNumber.one, (e1,e2) => e1 * e2);
      } else {
        throw new ExprUnhandledError("unhandled nary number expression $expr", expr);
      }
    } else {
      throw new ExprUnhandledError("unhandled number expression $expr", expr);
    }
    assert(res != null);
    return res;
  }
}

