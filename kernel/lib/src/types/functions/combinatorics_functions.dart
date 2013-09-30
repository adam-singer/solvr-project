// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

class CombinatoricsFunctions {
  static const BINOMIAL = const FunctionType("binomial", const [], LanguageTypes.NOTHING, AREA);

  static const FALLING_POWER = const FunctionType("fallingPower", const [], LanguageTypes.NOTHING, AREA);

  static const AreaType AREA = const AreaType("Combinatorics");
}
