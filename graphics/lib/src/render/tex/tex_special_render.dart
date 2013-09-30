// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_tex;

class _TexSpecialRender extends _AbstractTexRender implements SpecialRender {
  _TexSpecialRender(StringBuffer buf, ExprRender render): super(buf, render);
  
  render(Expr expr) {
  }
  
  renderAnonymousFunction(AnonymousFunctionExpr anon) {
    renderExpr(anon.args);
    add(r" => ");
    renderExpr(anon.body);
  }
  
  renderAssign(AssignExpr assign) {
    renderExpr(assign.variable);
    add(r" = ");
    renderExpr(assign.value);
  }
  
  renderFunction(FunctionExpr function) {
    // TODO render integrals and derivatives
    if(function.hasReturnType()) {
      renderExpr(function.returnType);
    }
    add(function.name);
    renderExpr(function.args);
    add(r" = ");
    renderExpr(function.body);
  }
  
  renderInvoke(InvokeExpr invoke) {
    add(invoke.name);
    renderExpr(invoke.args);
  }
  
  renderMethod(MethodExpr method) {
    renderExpr(method.target);
    add(".${method.name}");
    renderExpr(method.args);
  }
  
  renderSeq(SeqExpr sequence) {
    add(r"\left{");
    renderOperands("", r", ", r"", sequence.args);
    add(r" | ");
    renderExpr(sequence.body); 
    add(r"\right}");
  }
}
