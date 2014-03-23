// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_type_checker;

abstract class NullaryExprTypeVisitor implements NullaryExprVisitor {
  @override
  visitBoolExpr(BoolExpr expr) => null;
  
  @override
  visitNumberExpr(NumberExpr expr) => null;
  
  @override
  visitStringExpr(StringExpr expr) => null;
  
  @override
  visitSymbolExpr(SymbolExpr expr) => null;
  
  ExprVisitor get visitor;
}