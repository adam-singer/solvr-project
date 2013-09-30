// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_graphics_render_svg;

class _SvgNaryRender extends _AbstractSvgRender implements NaryExprVisitor {
  _SvgNaryRender(Element element, FontManager fontManager, ExprRender render): super(element, fontManager, render);
  
  renderInterval(IntervalExpr interval) {
  }
  
  renderList(ListExpr list) {
  }
  
  renderMatrix(MatrixExpr matrix) {
  }
  
  renderProduct(ProductExpr product) {
  }
  
  renderSet(SetExpr aSet) {
  }
  
  renderSum(SumExpr sum) {
  }
  
  renderTuple(TupleExpr tuple) {
  }
  
  renderVector(VectorExpr vector) {
  }
}
