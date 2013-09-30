// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

library solvr_graphics;

import 'dart:html';
import 'dart:svg';

import 'src/render/render_api_lib.dart';

part 'src/plot/array_plot.dart';
part 'src/plot/list_plot.dart';
part 'src/plot/plot.dart';
part 'src/plot/surface_plot.dart';

part 'src/utils/drawing_canvas.dart';
part 'src/utils/point_2d.dart';
part 'src/utils/rgba_color.dart';

ExprRender<String, String> get svgRender => null;

ExprRender<String, String> get texRender => null;

