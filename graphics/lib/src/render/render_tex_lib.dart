// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_graphics_tex_render;

import 'render_api_lib.dart';
import 'package:solvr_matchers/solvr_matchers.dart';

part 'tex/binary_expr_tex_render.dart';
part 'tex/tex_nary_render.dart';
part 'tex/nullary_expr_tex_render.dart';
part 'tex/special_expr_tex_render.dart';
part 'tex/unary_expr_tex_render.dart';

/** [ExprRender] that renders to LaTeX expression strings */
class TexRender extends Object with 
  BinaryExprTexRender,
  NaryExprTexRender, 
  NullaryExprTexRender, 
  SpecialExprTexRender,
  UnaryExprTexRender implements ExprVisitor, ExprRender<String,String> 
{
  attachTo(String target) {
    // TODO use JS api
    //var msg = {
    //   "mathString": _buf.toString(),
    //   "target": target
    //};
    //print("math rendering $msg");
    //window.postMessage(JSON.stringify(msg), '*');
  }
  
  String render(Expr expr) {
    _buf.clear();
    _mathRender.render(expr);
    return _buf.toString();
  }
  
  renderAndAttach(Expr expr, String target) {
    render(expr);
    attachTo(target);
  }
  
  final _buf = new StringBuffer();
}

