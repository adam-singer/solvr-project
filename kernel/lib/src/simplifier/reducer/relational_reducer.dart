// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Reduce relational expressions */
class RelationalReducer extends Reducer<Expr> {
  Expr reduce(Expr expr) {
    if(!isBinary(expr)) {
      throw new ExprUndefinedError("undefined relational operator $expr", expr);
    }
    return _reduceRelationalExpression(expr);
  }

  Expr _reduceRelationalExpression(BinaryExpr expr) {
    var e1 = expr.left;
    var e2 = expr.right;

    if(e1 == e2) {
      // relational testing on equal expressions (a + 1 == a + 1, x != x, x >= x, ...)
      if(expr.anyOf([isEqual, isGreaterThanOrEqual, isLessThanOrEqual])) {
        return asBool(true);
      } else if(expr.anyOf([isGreaterThan, isLessThan, isNotEqual])) {
        return asBool(false);
      } else {
        throw new ExprUnhandledError("unhandled binary relational operator $expr", expr);
      }
    } else if(e1.type != e2.type || !expr.operands.every(isObject)) {
      // for unequal expressions, only object expressions of similar type, can be compared
      return expr;
    }

    Expr res = expr;
    if(isEqual(expr)) {
      res = asBool(e1 == e2);
    } else if(isNotEqual(expr)) {
      res = asBool(e1 != e2);
    } else if(expr.operands.every(isNumber)) {
      // only attempt comparison of numerical values
      var val1 = valueOf(e1);
      var val2 = valueOf(e2);

      if(isGreaterThan(expr)) {
        res = asBool(val1 > val2);
      } else if(isGreaterThanOrEqual(expr)) {
        res = asBool(val1 >= val2);
      } else if(isLessThan(expr)) {
        res = asBool(val1 < val2);
      } else if(isLessThanOrEqual(expr)) {
        res = asBool(val1 <= val2);
      } else {
        throw new ExprUnhandledError("unhandled binary relational operator $expr", expr);
      }
    }
    return res;
  }
}
