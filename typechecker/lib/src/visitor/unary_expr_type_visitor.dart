// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_type_checker;

abstract class UnaryExprTypeVisitor implements UnaryExprVisitor {
  @override
  visitFactorialExpr(FactorialExpr expr) => null;
  
  @override
  visitNegationExpr(NegationExpr expr) => null;
  
  @override
  visitNegativeExpr(NegativeExpr expr) => null;
  
  ExprVisitor get visitor;
}