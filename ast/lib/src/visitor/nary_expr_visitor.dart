// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

abstract class NaryExprVisitor {
  // nary operator expr
  visitProductExpr(ProductExpr expr);
  
  visitSumExpr(SumExpr expr);
  
  // algebraic nary expr
  visitListExpr(ListExpr expr);
  
  visitMatrixExpr(MatrixExpr expr);
  
  visitSetExpr(SetExpr expr);
  
  visitTupleExpr(TupleExpr expr);
  
  visitVectorExpr(VectorExpr expr);
  
  // nary expr
  visitDictionaryExpr(DictionaryExpr expr);
  
  visitIntervalExpr(IntervalExpr expr);
}