// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

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
  static const FIBONACCI = const FunctionType("fibonacci", const [ObjectTypes.NUMBER], ObjectTypes.NUMBER, AREA);

  static const AreaType AREA = const AreaType("Number Theory");
}
