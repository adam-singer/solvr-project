// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_svg;

class _SvgSpecialRender extends _AbstractSvgRender implements SpecialRender {
  _SvgSpecialRender(Element element, Element glyphs): super(element, glyphs);
  
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
