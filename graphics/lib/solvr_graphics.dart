// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

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

