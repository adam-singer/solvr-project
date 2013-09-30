// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render;

abstract class NullaryRender {
  renderBool(BoolExpr expr);
  
  renderNumber(NumberExpr expr);
  
  renderSymbol(SymbolExpr expr);
}
