// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_graphics_render;

import 'package:solvr_ast/solvr_ast.dart';

export 'package:solvr_ast/solvr_ast.dart';
export 'package:solvr_common/solvr_common.dart';

part 'api/binary_expr_render.dart';
part 'api/nary_expr_render.dart';
part 'api/nullary_expr_render.dart';
part 'api/special_expr_render.dart';
part 'api/unary_expr_render.dart';

abstract class ExprRender<T,R> {
  R render(Expr expr);
  
  renderAndAttach(Expr expr, T target);
}