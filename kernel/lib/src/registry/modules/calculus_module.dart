// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_registry;

class CalculusModule extends AbstractModule {
  CalculusModule() {
    registerFunction(new _DerivativeFn());
    registerFunction(new _DSolveFn());
    registerFunction(new _IntegrateFn());
    registerFunction(new _LimitFn());
    //registerFunction(new _ProductOfFn());
    //registerFunction(new _SumOfFn());
  }
}

class _DerivativeFn extends AbstractFunction {
  _DerivativeFn(): super(CalculusFunctions.DERIVATIVE);

  Expr apply(TupleExpr args) {
    return derivative(args[0], args[1]);
  }
}

class _DSolveFn extends AbstractFunction {
  _DSolveFn(): super(CalculusFunctions.D_SOLVE);

  Expr apply(TupleExpr args) {
    return solveOde(args[0], args[1], args[2]);
  }
}

class _IntegrateFn extends AbstractFunction {
  _IntegrateFn(): super(CalculusFunctions.INTEGRATE);

  Expr apply(TupleExpr args) {
    return integrate(args[0], args[1]);
  }
}

class _LimitFn extends AbstractFunction {
  _LimitFn(): super(CalculusFunctions.LIMIT);

  Expr apply(TupleExpr args) {
    throw "TODO limit";
  }
}

/*
class _ProductOfFn extends AbstractFunction {
  _ProductOfFn(): super(CalculusFunctions.PRODUCT_OF);

  Expr apply(TupleExpr args) {
    return productOf(args[0], args[1]);
  }
}

class _SumOfFn extends AbstractFunction {
  _SumOfFn(): super(CalculusFunctions.SUM_OF);

  Expr apply(TupleExpr args) {
    return sumOf(args[0], args[1]);
  }
}
*/


