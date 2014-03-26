// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_type_checker;

abstract class NaryExprTypeVisitor implements NaryExprVisitor {
  @override
  visitProductExpr(ProductExpr expr) => null;
  
  @override
  visitSumExpr(SumExpr expr) => null;
  
  @override
  visitListExpr(ListExpr expr) => null;
  
  @override
  visitMatrixExpr(MatrixExpr expr) => null;
  
  @override
  visitSetExpr(SetExpr expr) => null;
  
  @override
  visitTupleExpr(TupleExpr expr) => null;
  
  @override
  visitVectorExpr(VectorExpr expr) => null;
  
  @override
  visitDictionaryExpr(DictionaryExpr expr) => null;
  
  @override
  visitIntervalExpr(IntervalExpr expr) => null;
  
  ExprVisitor get visitor;
}