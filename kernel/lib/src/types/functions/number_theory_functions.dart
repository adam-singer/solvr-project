// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

class NumberTheoryFunctions {
  static const ABS = const FunctionType("abs", const [InterfaceTypes.EXPRESSION], InterfaceTypes.EXPRESSION, AREA);

  static const DECIMALIZE = const FunctionType("decimalize", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const DIV = const FunctionType("div", const [ObjectTypes.NUMBER,ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const GCD = const FunctionType("gcd", const [HelperTypes.MIN_TWO_NUMBERS], ObjectTypes.NUMBER, AREA);

  static const ISPRIME = const FunctionType("isPrime", const [ObjectTypes.NUMBER], ObjectTypes.BOOL, AREA);

  static const LCM = const FunctionType("lcm", const [HelperTypes.MIN_TWO_NUMBERS], ObjectTypes.NUMBER, AREA);

  static const MOD = const FunctionType("mod", const [ObjectTypes.NUMBER, ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const NTHROOT = const FunctionType("nthRoot", const [ObjectTypes.NUMBER, ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const PRIMENUMBER = const FunctionType("primeNumber", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const RATIONALIZE = const FunctionType("rationalize", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const RATIONALIZE_SYMBOL = const FunctionType("rationalize", const [ObjectTypes.SYMBOL], ObjectTypes.NUMBER, AREA);

  static const SQRT = const FunctionType("sqrt", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  // Fibonacci family of functions
  static const FIBONACCI = const FunctionType("fibonacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const TRIBONACCI = const FunctionType("tribonacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const TETRANACCI = const FunctionType("tetranacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const PENTANACCI = const FunctionType("pentanacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const HEXANACCI = const FunctionType("hexanacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const HEPTANACCI = const FunctionType("heptanacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const OCTONACCI = const FunctionType("octonacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const NONANACCI = const FunctionType("nonanacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const DECANACCI = const FunctionType("decanacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const AreaType AREA = const AreaType("Number Theory");
}
