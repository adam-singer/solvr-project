// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Reduce logical expressions */
class LogicalReducer extends Reducer<Expr> {
  Expr reduce(Expr expr) => _reduceLogicalExpression(expr);

  Expr _reduceLogicalExpression(var expr) {
    if(expr is BoolExpr) {
      return expr;
    } else if(!expr.operands.every(isBool)) {
      // for logical operations on non-booleans just return the expression
      return expr;
    } else if(expr is UnaryExpr) {
      bool b = _asBoolValue(expr.operand);
      if(expr is NegationExpr) {
        return asBool(!b);
      }
    } else if(isBinary(expr)) {
      bool e1 = _asBoolValue(expr.left);
      bool e2 = _asBoolValue(expr.right);
      if(expr is AndExpr) {
        return asBool(e1 && e2);
      } else if(expr is OrExpr) {
        return asBool(e1 || e2);
      }
    }
    throw new ExprUnhandledError("unhandled logical expression $expr", expr);
  }

  bool _asBoolValue(BoolExpr boolean) {
    return boolean.value;
  }
}
