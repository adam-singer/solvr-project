// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

class LinearAlgebraFunctions {
  static const CROSS_PRODUCT = const FunctionType("cross", const [], InterfaceTypes.EXPRESSION, AREA);

  static const NORM = const FunctionType("norm", const [], InterfaceTypes.EXPRESSION, AREA);

  static const RANK = const FunctionType("rank", const [], InterfaceTypes.EXPRESSION, AREA);

  // TODO LARS import remaining linear algebra functions from kernel sandbox
  // TODO use text keys for AREA names so they can be internationalized

  static const AreaType AREA = const AreaType("Linear Algebra");
}
