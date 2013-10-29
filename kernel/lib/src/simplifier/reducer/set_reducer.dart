// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Reduce sets expressions */
class SetReducer extends Reducer<Expr> {
  SetReducer(this._simplifier);

  Expr reduce(Expr expr) {
    Expr res = _reduceSetsExpression(expr);
    return (isSet(res)) ? _orderSet(res) : res;
  }

  Expr _reduceSetsExpression(var expr) {
    if(isSet(expr)) {
      return expr;
    } else if(isBinary(expr)) {
      if(isEntry(expr)) {
        return expr;
      }

      SetExpr s1 = expr.left;
      SetExpr s2 = expr.right;

      if(isSubset(expr)) {
        return asBool(s2.subset(s1));
      } else if(isNotSubset(expr)) {
        return asBool(!s2.subset(s1));
      } else if(isComplement(expr)) {
        return s1.complement(s2);
      } else if(isIntersect(expr)) {
        return s1.intersect(s2);
      } else if(isUnion(expr)) {
        return s1.union(s2);
      }
    }
    throw new ExprUndefinedError('unhandled set expression $expr', expr);
  }

  SetExpr _orderSet(SetExpr aSet) {
    List<Expr> elements = aSet.operands;
    elements.sort((Expr a, Expr b) => (a == b) ? 0 : (isInOrder(a,b) ? -1 : 1));
    return new SetExpr(elements);
  }
  
  final AutomaticSimplifier _simplifier;
}
