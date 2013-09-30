// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

class CalculusFunctions {
  static const DERIVATIVE = const FunctionType("derivative", const [InterfaceTypes.EXPRESSION, ObjectTypes.SYMBOL], InterfaceTypes.EXPRESSION, AREA);

  static const D_SOLVE = const FunctionType("dsolve", const [], LanguageTypes.NOTHING, AREA);

  static const INTEGRATE = const FunctionType("integrate", const [InterfaceTypes.EXPRESSION, ObjectTypes.SYMBOL], InterfaceTypes.EXPRESSION, AREA);

  static const LIMIT = const FunctionType("limit", const [], LanguageTypes.NOTHING, AREA);

  static const PRODUCT_OF = const FunctionType("productOf", const [], LanguageTypes.NOTHING, AREA);

  static const SUM_OF = const FunctionType("sumOf", const [], LanguageTypes.NOTHING, AREA);

  static const AreaType AREA = const AreaType("Calculus");
}
