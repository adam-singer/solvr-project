// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_kernel_math_registry;

class AlgebraModule extends AbstractModule {
  AlgebraModule() {
    registerFunction(new _CoefficientFn());
    registerFunction(new _DegreeFn());
    registerFunction(new _DenominatorFn());
    registerFunction(new _ExpandFn());
    registerFunction(new _IsPolynomialFn());
    registerFunction(new _IsPolynomialSetFn());
    registerFunction(new _LcfFn());
    registerFunction(new _NumeratorFn());
    registerFunction(new _VariablesFn());
  }
}

class _CoefficientFn extends AbstractFunction {
  _CoefficientFn(): super(AlgebraFunctions.COEFFICIENT);

  Expr apply(TupleExpr args) {
    //List args = argsAsList(args, converters:[asExpr, asExpr, asNonNegativeIntegerExpr], exactLength:3);
    return coefficientOf(args[0], args[1], args[2]);
  }
}

class _DegreeFn extends AbstractFunction {
  _DegreeFn(): super(AlgebraFunctions.DEGREE);

  Expr apply(TupleExpr args) {
    return asInteger(degreeOf(args[0], args[1]));
  }
}

class _DenominatorFn extends AbstractFunction {
  _DenominatorFn(): super(AlgebraFunctions.DENOMINATOR);

  Expr apply(TupleExpr args) {
    var expr = args[0];
    return denominatorOf(args[0]);
  }
}

class _ExpandFn extends AbstractFunction {
  _ExpandFn(): super(AlgebraFunctions.EXPAND);

  Expr apply(TupleExpr args) {
    return expand(args[0]);
  }
}

class _IsPolynomialFn extends AbstractFunction {
  _IsPolynomialFn(): super(AlgebraFunctions.IS_POLYNOMIAL);

  Expr apply(TupleExpr args) {
    var expr = args[0];
    var symbolSet = asSet([ args[1] ]);
    return asBool(isPolynomial(expr, symbolSet));
  }
}

class _IsPolynomialSetFn extends AbstractFunction {
  _IsPolynomialSetFn(): super(AlgebraFunctions.IS_POLYNOMIAL_SET);

  Expr apply(TupleExpr args) {
    var expr = args[0];
    var symbolSet = args[1];
    return asBool(isPolynomial(expr, symbolSet));
  }
}

class _LcfFn extends AbstractFunction {
  _LcfFn(): super(AlgebraFunctions.LCF);

  Expr apply(TupleExpr args) {
    return lcf(args[0], args[1]);
  }
}

class _NumeratorFn extends AbstractFunction {
  _NumeratorFn(): super(AlgebraFunctions.NUMERATOR);

  Expr apply(TupleExpr args) {
    return numeratorOf(args[0]);
  }
}

class _VariablesFn extends AbstractFunction {
  _VariablesFn(): super(AlgebraFunctions.VARIABLES);

  Expr apply(TupleExpr args) {
    return variablesOf(args[0]);
  }
}


