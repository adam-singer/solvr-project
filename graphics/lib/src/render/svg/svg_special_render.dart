// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_graphics_render_svg;

class _SvgSpecialRender extends _AbstractSvgRender implements SpecialRender {
  _SvgSpecialRender(Element element, FontManager fontManager, ExprRender render): super(element, fontManager, render);
  
  renderAnonymousFunction(AnonymousFunctionExpr assign) {
  }
  
  renderAssign(AssignExpr assign) {
  }
  
  renderFunction(FunctionExpr function) {
  }
  
  renderInvoke(InvokeExpr invoke) {
    if(invoke.name == "plot") {
      
    }
  }
  
  renderMethod(MethodExpr method) {
  }
  
  renderSeq(SeqExpr sequence){
  }
}
