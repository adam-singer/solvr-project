// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

class GraphFunctions {
  static const FUNCTION_PLOT = const FunctionType("plot", const [], LanguageTypes.NOTHING, AREA);
  static const LIST_PLOT = const FunctionType("listPlot", const [], LanguageTypes.NOTHING, AREA);
  static const SURFACE_PLOT = const FunctionType("surfacePlot", const [], LanguageTypes.NOTHING, AREA);
  static const AreaType AREA = const AreaType("Graphs");
}
