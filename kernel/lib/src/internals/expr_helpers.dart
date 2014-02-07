// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

// Power helpers
Expr baseOf(var expr) => isPower(expr) ? expr.left : expr;

Expr exponentOf(var expr) => isPower(expr) ? expr.right : one;

Expr invert(var expr) => asPower(expr, minusOne);

// Set helpers 
SetExpr get emptySet => asSet([]);

// Product helpers 
/** Construct a product from a list, return one if the list is empty */
Expr productOf(List<Expr> operands) {
  if(operands.length == 0) {
    return one;
  } else if(operands.length == 1) {
    return operands[0];
  }
  return new ProductExpr(operands);
}

// Sum helpers 
/** Construct a sum from a list, return zero if the list is empty */
Expr sumOf(List<Expr> operands) {
  if(operands.length == 0) {
    return zero;
  } else if(operands.length == 1) {
    return operands[0];
  }
  return new SumExpr(operands);
}

// Number helpers 
bool isNotNumber(var expr) => (expr is! NumberExpr);

bool isQuotient(var expr) => isNumber(expr) && !isInteger(expr);

bool isOne(var expr) => (isInteger(expr) && expr == one);

bool isZero(var expr) => (isNumber(expr) && expr == zero);

bool isMinusOne(var expr) => (isNegativeNumber(expr) && expr == minusOne);

bool isPositiveNumber(var expr) => (isNumber(expr) && expr.numerator.isPositive);

bool isNegativeNumber(var expr) => (isNumber(expr) && expr.numerator.isNegative);

bool isPositiveInteger(var expr) => (isInteger(expr) && isPositiveNumber(expr));

bool isNegativeInteger(var expr) => (isInteger(expr) && isNegativeNumber(expr));

bool isHalf(var expr) => (isNumber(expr) && expr == half);

NumberExpr get two => asInteger(Integer.two);

NumberExpr get one => asInteger(Integer.one);

NumberExpr get half => new NumberExpr(Integer.one, Integer.two);

NumberExpr get zero => asInteger(Integer.zero);

NumberExpr get minusOne => asInteger(Integer.minusOne);

// Symbol helpers 
SymbolExpr get euler => asSymbol("e");

SymbolExpr get infinity => asSymbol("infinity");

SymbolExpr get minusInfinity => asSymbol("-infinity");

SymbolExpr get pi => asSymbol("pi");

bool isEuler(var expr) => isSymbol(expr) && expr == euler;

bool isInfinity(var expr) => isSymbol(expr) && expr == infinity;

bool isMinusInfinity(var expr) => isSymbol(expr) && expr == minusInfinity;

bool isPi(var expr) => isSymbol(expr) && expr == pi;

bool isImaginary(var expr) => isSymbol(expr) && expr.value == "i";

// Operator helpers
bool isAlgebraicCollection(var expr) => isCollection(expr) && _hasInterface(expr.type, InterfaceTypes.ALGEBRAIC_COLLECTION);

bool isAlgebraicOperator(Expr expr) => _isOperatorType(expr, OperatorTypes.ALGEBRAIC);

bool isLogicalOperator(Expr expr) => _isOperatorType(expr, OperatorTypes.LOGICAL);

bool isObjectOperator(Expr expr) => _isOperatorType(expr, OperatorTypes.OBJECT);

bool isRelationalOperator(Expr expr) => _isOperatorType(expr, OperatorTypes.RELATIONAL);

bool isSetOperator(Expr expr) => _isOperatorType(expr, OperatorTypes.SET);

// Expression helpers
bool isLexical(var expr) => isSymbol(expr) || isNumber(expr);

bool isAlgebraic(Expr expr) {
  if(isOperator(expr.type)) {
    return isAlgebraicOperator(expr);
  } else if(isObject(expr)) {
    return _hasInterface(expr.type, InterfaceTypes.EXPRESSION);
  }
  return false;
}

/**
 * Returns true if the expression represents a negative value. Only works on automatically
 * simplified expressions
 */
bool isNegativeExpr(var expr) {
  if(isNegative(expr)) {
    return true;
  } else if(isNegativeNumber(expr)) {
    return true;
  } else {
    // negative expressions are represented as -1 * expr
    return (isProduct(expr) && isMinusOne(expr.operands[0]));
  }
}

bool isPositiveExpr(var expr) => !isNegativeExpr(expr);

/** Convert expression into an primitive value */
dynamic valueOf(var expr) {
  if(isNumber(expr)) {
    return new RationalNumber(expr.numerator, expr.denominator);
  } else if(isSymbol(expr) || isBool(expr)) {
    return expr.value;
  } else if(isProduct(expr)) {
    var operands = expr.operands;
    if(operands.length > 2) {
      throw new ArgumentError("n-ary product must be simplified before it can be converted into to a primitive value");
    }
    var left = operands[0];
    var right = operands[1];
    // handle negative numbers being represented as fx -3 = -1 * 3
    if(left.toString() == "-1" && isNumber(right)) {
      var number = new RationalNumber(right.numerator, right.denominator);
      return number;
    }
  }
  throw new ArgumentError("cannot convert $expr into an primitive value");
}

// private
bool _hasInterface(var type, InterfaceType inf) => type.hasInterface(inf);

bool _isOperatorType(Expr expr, AreaType operatorArea) => (expr.type is OperatorType) ? (expr.type as OperatorType).area == operatorArea : false;
