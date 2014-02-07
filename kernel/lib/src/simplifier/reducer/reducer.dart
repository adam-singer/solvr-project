// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

abstract class Reducer<T extends Expr> {
  Expr reduce(T expr);
}

/**
 * True when expression e1 is ordered correctly mathematically in comparison with e2.
 *
 * Note this algorithm assumes that each of the two expressions are simplified and thus
 * internally ordered. For example the order of b+1+2 and 2+a+3 cannot be correctly
 * determined since they are not on simplified form (3+b and 5+a)
 */
bool isInOrder(var e1, var e2) {
  // Equal argument types 

  // 2, 3, 4, ...
  if(isNumber(e1) && isNumber(e2)) {
    return valueOf(e1) <= valueOf(e2);
  }

  // X,Y,Z, ... x, y, z, ... v1, v2, ...
  if(isLexical(e1) && isLexical(e2)) {
    return _stringCompare(_asString(e1), _asString(e2));
  }

  // ordering of expressions of like types is determined by comparing their operands
  bool handleSame(List<Expr> u, List<Expr> v) {
    while(u.last == v.last && u.length >= 2 && v.length >= 2) {
      // when the last operands are equal focus shifts to the operands before
      u = headSet(u);
      v = headSet(v);
    }

    if(u.last != v.last) {
      return isInOrder(u.last, v.last);
    }
    return u.length <= v.length;
  }

  if(isProduct(e1) && isProduct(e2)) {
    return handleSame(e1.operands, e2.operands);
  }

  if(isSum(e1) && isSum(e2)) {
    return handleSame(e1.operands, e2.operands);
  }

  if(isSubstitution(e1) && isSubstitution(e2)) {
    return handleSame(e1.operands, e2.operands);
  }

  if( (isAlgebraicCollection(e1) && isAlgebraicCollection(e2)) ) {
    bool inOrder;
    if([e1, e2].any(isMatrix)) {
      return true;
    } else {
      inOrder = (e1.length <= e2.length) ? true : false;
    }
    if(e1.type == e2.type) {
      // (x) < (y) = true, (x) < (x,y) = true, ...
      mapI(e1.operands, (Expr e, int i) {
        if(i > e2.length - 1) return;
        if(!isInOrder(e1[i], e2[i])) {
          inOrder = false;
          return;
        }
      });
    }
    return inOrder;
  }

  if(isPower(e1) && isPower(e2)) {
    return (baseOf(e1) != baseOf(e2)) ? isInOrder(baseOf(e1), baseOf(e2)) : isInOrder(exponentOf(e1), exponentOf(e2));
  }

  if(isFactorial(e1) && isFactorial(e2)) {
    return isInOrder(e1.operand, e2.operand);
  }

  if(isInvoke(e1) && isInvoke(e2)) {
    if(e1.name != e2.name) {
      // f(x) < g(x)
      return _stringCompare(e1.name, e2.name);
    }
    return isInOrder(e1.args, e2.args);
  }

  // Unequal argument types 

  if(isNumber(e1) && !isNumber(e2)) {
    return true;
  }

  if(isProduct(e1) && e2.anyOf([isPower, isSum, isFactorial, isInvoke, isSymbol])) {
    // a * x^2 < x^3 = a*x^2 < 1*x^3 = x^2 < x^3 = 2 < 3 = true
    return isInOrder(e1, one * e2);
  }

  if(isPower(e1) && e2.anyOf([isSum, isFactorial, isInvoke, isSymbol])) {
    // e2 = e2^1
    return isInOrder(e1, asPower(e2, one));
  }

  if(isSum(e1) && e2.anyOf([isFactorial, isInvoke, isSymbol])) {
    // e2 = e2 + 0
    return isInOrder(e1, e2 + zero);
  }

  if(isFactorial(e1) && e2.anyOf([isInvoke, isSymbol])) {
    if(e1.operand == e2) return false;
    return isInOrder(e1, factorial(e2));
  }

  if(isInvoke(e1) && isSymbol(e2)) {
    if(e1.name == e2.value) return false;
    return isInOrder(asSymbol(e1.name), e2);
  }

  if(isTuple(e1) && !isTuple(e2)) {
    // e2 = (e2)
    return isInOrder(e1, asTuple(e2));
  }

  if(!isAlgebraicCollection(e1) && isAlgebraicCollection(e2)) {
    // a * [1 2 3]
    return true;
  }

  // x < x^2 = not(x^2 < x) = not(x^2 < x^1) = not(2 < 1) = not(false) = true
  return !isInOrder(e2, e1);
}

_asString(NullaryExpr expr) => valueOf(expr).toString();

bool _stringCompare(s1, s2) => s1.compareTo(s2) <= 0;

