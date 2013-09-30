// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render;

abstract class NaryRender {
  renderInterval(IntervalExpr interval);
  
  renderList(ListExpr list);
  
  renderMatrix(MatrixExpr matrix);
  
  renderProduct(ProductExpr product);
  
  renderSet(SetExpr aSet);
  
  renderSum(SumExpr sum);
  
  renderTuple(TupleExpr tuple);
  
  renderVector(VectorExpr vector);
}
