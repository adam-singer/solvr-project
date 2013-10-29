// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_registry;

class NumberTheoryModule extends AbstractModule {
  NumberTheoryModule() {
    registerFunction(new _AbsFn());
    registerFunction(new _DecimalizeFn());
    registerFunction(new _DivFn());
    registerFunction(new _GcdFn());
    registerFunction(new _IsPrimeFn());
    registerFunction(new _LcmFn());
    registerFunction(new _ModFn());
    registerFunction(new _NthRootFn());
    registerFunction(new _PrimeNumberFn());
    registerFunction(new _RationalizeFn());
    registerFunction(new _RationalizeSymbolFn());
    registerFunction(new _SqrtFn());

    // Fibonacci family of functions
    registerFunction(new _FibonacciFn());
    registerFunction(new _TribonacciFn());
    registerFunction(new _TetranacciFn());
    registerFunction(new _PentanacciFn());
    registerFunction(new _HexanacciFn());
    registerFunction(new _HeptanacciFn());
    registerFunction(new _OctonacciFn());
    registerFunction(new _NonanacciFn());
    registerFunction(new _DecanacciFn());
  }
}

class _AbsFn extends AbstractFunction {
  _AbsFn(): super(NumberTheoryFunctions.ABS);

  Expr apply(TupleExpr args) {
    return abs(args[0]);
  }
}

class _DecimalizeFn extends AbstractFunction {
  _DecimalizeFn(): super(NumberTheoryFunctions.DECIMALIZE);

  Expr apply(TupleExpr args) {
    return decimalize(args[0]);
  }
}

class _DivFn extends AbstractFunction {
  _DivFn(): super(NumberTheoryFunctions.DIV);

  Expr apply(TupleExpr args) {
    var x = asInteger(args[0]);
    var y = asInteger(args[1]);
    return asNumber(div(x, y));
  }
}

class _GcdFn extends AbstractFunction {
  _GcdFn(): super(NumberTheoryFunctions.GCD);

  Expr apply(TupleExpr args) {
    return asNumber(greatestCommonDevisor(asIntegerList(args)));
  }
}

class _IsPrimeFn extends AbstractFunction {
  _IsPrimeFn(): super(NumberTheoryFunctions.ISPRIME);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asBool(isPrime(n));
  }
}

class _LcmFn extends AbstractFunction {
  _LcmFn(): super(NumberTheoryFunctions.LCM);

  Expr apply(TupleExpr args) {
    return asNumber(leastCommonMultiple(asIntegerList(args)));
  }
}

class _ModFn extends AbstractFunction {
  _ModFn(): super(NumberTheoryFunctions.MOD);

  Expr apply(TupleExpr args) {
    var x = asInteger(args[0]);
    var y = asInteger(args[1]);
    return asNumber(mod(x, y));
  }
}

class _NthRootFn extends AbstractFunction {
  _NthRootFn() : super(NumberTheoryFunctions.NTHROOT);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    var r = asInteger(args[1]);
    return asNumber(nthRoot(n,r));
  }
}

class _PrimeNumberFn extends AbstractFunction {
  _PrimeNumberFn() : super(NumberTheoryFunctions.PRIMENUMBER);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(primeNumber(n));
  }
}

class _RationalizeFn extends AbstractFunction {
  _RationalizeFn(): super(NumberTheoryFunctions.RATIONALIZE);

  Expr apply(TupleExpr args) {
    return rationalize(args[0]);
  }
}

class _RationalizeSymbolFn extends AbstractFunction {
  _RationalizeSymbolFn(): super(NumberTheoryFunctions.RATIONALIZE_SYMBOL);

  Expr apply(TupleExpr args) {
    return rationalize(args[0]);
  }
}

class _SqrtFn extends AbstractFunction {
  _SqrtFn(): super(NumberTheoryFunctions.SQRT);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nthRoot(n, Integer.two));
  }
}

class _FibonacciFn extends AbstractFunction {
  _FibonacciFn(): super(NumberTheoryFunctions.FIBONACCI);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nacciSequence(n, "fibo"));
  }
}

class _TribonacciFn extends AbstractFunction {
  _TribonacciFn(): super(NumberTheoryFunctions.TRIBONACCI);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nacciSequence(n, "tribo"));
  }
}

class _TetranacciFn extends AbstractFunction {
  _TetranacciFn(): super(NumberTheoryFunctions.TETRANACCI);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nacciSequence(n, "tetra"));
  }
}

class _PentanacciFn extends AbstractFunction {
  _PentanacciFn(): super(NumberTheoryFunctions.PENTANACCI);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nacciSequence(n, "penta"));
  }
}

class _HexanacciFn extends AbstractFunction {
  _HexanacciFn(): super(NumberTheoryFunctions.HEXANACCI);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nacciSequence(n, "hexa"));
  }
}

class _HeptanacciFn extends AbstractFunction {
  _HeptanacciFn(): super(NumberTheoryFunctions.HEPTANACCI);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nacciSequence(n, "hepta"));
  }
}

class _OctonacciFn extends AbstractFunction {
  _OctonacciFn(): super(NumberTheoryFunctions.OCTONACCI);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nacciSequence(n, "octo"));
  }
}

class _NonanacciFn extends AbstractFunction {
  _NonanacciFn(): super(NumberTheoryFunctions.NONANACCI);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nacciSequence(n, "nona"));
  }
}

class _DecanacciFn extends AbstractFunction {
  _DecanacciFn(): super(NumberTheoryFunctions.DECANACCI);

  Expr apply(TupleExpr args) {
    var n = asInteger(args[0]);
    return asNumber(nacciSequence(n, "deca"));
  }
}





