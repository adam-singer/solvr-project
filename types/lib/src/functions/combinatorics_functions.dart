// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

class CombinatoricsFunctions {
  static const BINOMIAL = const FunctionType("binomial", const [], LanguageTypes.NOTHING, AREA);
  static const FALLING_POWER = const FunctionType("fallingPower", const [], LanguageTypes.NOTHING, AREA);
  static const AreaType AREA = const AreaType("Combinatorics");
}
