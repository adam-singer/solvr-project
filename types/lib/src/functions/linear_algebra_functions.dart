// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

class LinearAlgebraFunctions {
  static const CROSS_PRODUCT = const FunctionType("cross", const [], InterfaceTypes.EXPRESSION, AREA);
  static const NORM = const FunctionType("norm", const [], InterfaceTypes.EXPRESSION, AREA);
  static const RANK = const FunctionType("rank", const [], InterfaceTypes.EXPRESSION, AREA);

  // TODO LARS import remaining linear algebra functions from kernel sandbox
  // TODO use text keys for AREA names so they can be internationalized

  static const AreaType AREA = const AreaType("Linear Algebra");
}
