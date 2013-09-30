// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

class CalculusFunctions {
  static const DERIVATIVE = const FunctionType("derivative", const [InterfaceTypes.EXPRESSION, ObjectTypes.SYMBOL], InterfaceTypes.EXPRESSION, AREA);
  static const D_SOLVE = const FunctionType("dsolve", const [], LanguageTypes.NOTHING, AREA);
  static const INTEGRATE = const FunctionType("integrate", const [InterfaceTypes.EXPRESSION, ObjectTypes.SYMBOL], InterfaceTypes.EXPRESSION, AREA);
  static const LIMIT = const FunctionType("limit", const [], LanguageTypes.NOTHING, AREA);
  static const PRODUCT_OF = const FunctionType("productOf", const [], LanguageTypes.NOTHING, AREA);
  static const SUM_OF = const FunctionType("sumOf", const [], LanguageTypes.NOTHING, AREA);
  static const AreaType AREA = const AreaType("Calculus");
}
