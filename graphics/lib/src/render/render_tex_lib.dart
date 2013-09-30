// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_graphics_render_tex;

import 'render_api_lib.dart';
import 'package:solvr_matchers/solvr_matchers.dart';

part 'tex/abstract_tex_render.dart';
part 'tex/tex_binary_render.dart';
part 'tex/tex_nary_render.dart';
part 'tex/tex_nullary_render.dart';
part 'tex/tex_special_render.dart';
part 'tex/tex_unary_render.dart';

/** [ExprRender] that renders to LaTeX expression strings */
class TexRender implements ExprRender<String,String> {
  TexRender() {
    var binaryRender = new _TexBinaryRender(_buf, this);
    var naryRender = new _TexNaryRender(_buf, this);
    var nullaryRender = new _TexNullaryRender(_buf, this);
    var specialRender = new _TexSpecialRender(_buf, this);
    var unaryRender = new _TexUnaryRender(_buf, this);
  }
  
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

