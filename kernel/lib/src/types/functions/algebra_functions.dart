// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

class AlgebraFunctions {
  static const COEFFICIENT = const FunctionType("coefficient", const [InterfaceTypes.EXPRESSION, InterfaceTypes.EXPRESSION, ObjectTypes.NUMBER], InterfaceTypes.EXPRESSION, AREA);

  static const DEGREE = const FunctionType("degree", const [InterfaceTypes.EXPRESSION, InterfaceTypes.EXPRESSION], InterfaceTypes.EXPRESSION, AREA);

  static const DENOMINATOR = const FunctionType("denominator", const [InterfaceTypes.EXPRESSION], InterfaceTypes.EXPRESSION, AREA);

  static const EXPAND = const FunctionType("expand", const [InterfaceTypes.EXPRESSION], InterfaceTypes.EXPRESSION, AREA);

  static const IS_POLYNOMIAL = const FunctionType("isPolynomial", const [InterfaceTypes.EXPRESSION, ObjectTypes.SYMBOL], ObjectTypes.BOOL, AREA);

  static const IS_POLYNOMIAL_SET = const FunctionType("isPolynomial", const [InterfaceTypes.EXPRESSION, ObjectTypes.SET], ObjectTypes.BOOL, AREA);

  static const LCF = const FunctionType("lcf", const [InterfaceTypes.EXPRESSION, InterfaceTypes.EXPRESSION], ObjectTypes.NUMBER, AREA);

  static const NUMERATOR = const FunctionType("numerator", const [InterfaceTypes.EXPRESSION], InterfaceTypes.EXPRESSION, AREA);

  static const VARIABLES = const FunctionType("variables", const [InterfaceTypes.EXPRESSION], ObjectTypes.LIST, AREA);

  static const AreaType AREA = const AreaType("Algebra");
}
