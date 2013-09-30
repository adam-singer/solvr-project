// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

part of solvr_graphics_render_tex;

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

