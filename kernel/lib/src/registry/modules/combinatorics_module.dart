// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_registry;

class CombinatoricsModule extends AbstractModule {
  CombinatoricsModule() {
    registerFunction(new _BinomialFn());
    registerFunction(new _FactorialPower());
  }
}

class _BinomialFn extends AbstractFunction {
  _BinomialFn(): super(CombinatoricsFunctions.BINOMIAL);

  Expr apply(TupleExpr args) {
    // TODO check arguments
    exprFrom(expectNumber(args).abs);
  }
}

class _FactorialPower extends AbstractFunction {
  _FactorialPower(): super(CombinatoricsFunctions.FALLING_POWER);

  Expr apply(TupleExpr args) {
    //assertArgumentList(args, isNumber, [2,3]);
    //var x = asInt(args[0]);
    //var n = asInt(args[1]);
    //var h = (args.length == 3) ? asInt(args[2]) : Integer.one;
    //return exprFrom(factorialPower(x, n, h));
  }
}
