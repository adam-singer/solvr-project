// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

class GraphFunctions {
  static const FUNCTION_PLOT = const FunctionType("plot", const [], LanguageTypes.NOTHING, AREA);

  static const LIST_PLOT = const FunctionType("listPlot", const [], LanguageTypes.NOTHING, AREA);

  static const SURFACE_PLOT = const FunctionType("surfacePlot", const [], LanguageTypes.NOTHING, AREA);

  static const AreaType AREA = const AreaType("Graphs");
}
