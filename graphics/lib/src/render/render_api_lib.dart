// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_graphics_render;

import 'package:solvr_ast/solvr_ast.dart';

export 'package:solvr_ast/solvr_ast.dart';
export 'package:solvr_common/solvr_common.dart';

abstract class ExprRender<T,R> {
  R render(Expr expr);
  
  renderAndAttach(Expr expr, T target);
}