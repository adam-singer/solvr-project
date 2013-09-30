// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

library solvr_graphics_render;

export 'package:solvr_common/solvr_common.dart';
import 'package:solvr_kernel/solvr_kernel.dart';
export 'package:solvr_kernel/solvr_kernel.dart';

part 'api/binary_render.dart';
part 'api/nary_render.dart';
part 'api/nullary_render.dart';
part 'api/special_render.dart';
part 'api/unary_render.dart';

abstract class ExprRender<T,R> {
  attachTo(T target);
  
  R render(Expr expr);
  
  renderAndAttach(Expr expr, T target);
}