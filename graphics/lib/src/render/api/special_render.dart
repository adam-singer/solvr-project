// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render;

abstract class SpecialRender {
  renderAnonymousFunction(AnonymousFunctionExpr assign);
  
  renderAssign(AssignExpr assign);
  
  renderFunction(FunctionExpr function);
  
  renderInvoke(InvokeExpr invoke);
  
  renderMethod(MethodExpr method);
  
  renderSeq(SeqExpr sequence);
}
