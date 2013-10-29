// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Visit binary expressions (expressions with two operands) */
abstract class BinaryExprVisitor {
  visitComplexNumberExpr(ComplexNumberExpr expr);
  
  visitDifferenceExpr(DifferenceExpr expr);
  
  visitDotExpr(DotExpr expr);
  
  visitFractionExpr(FractionExpr expr);
  
  visitPowerExpr(PowerExpr expr);
  
  visitAndExpr(AndExpr expr);
  
  visitOrExpr(OrExpr expr);
  
  visitBindExpr(BindExpr expr);
  
  visitGuardExpr(GuardExpr expr);
  
  visitInstanceOfExpr(InstanceOfExpr expr);
  
  visitNotInstanceOfExpr(NotInstanceOfExpr expr);
  
  visitSubsitutionExpr(SubstitutionExpr expr);
  
  visitEqualExpr(EqualExpr expr);
  
  visitGreaterThanExpr(GreaterThanExpr expr);
  
  visitGreaterThanOrEqualExpr(GreaterThanOrEqualExpr expr);
  
  visitLessThanExpr(LessThanExpr expr);
  
  visitLessThanOrEqualExpr(LessThanOrEqualExpr expr);
  
  visitNotEqualExpr(NotEqualExpr expr);
  
  visitComplementExpr(ComplementExpr expr);
  
  visitEntryExpr(EntryExpr expr);
  
  visitIntersectExpr(IntersectExpr expr);
  
  visitNotSubsetExpr(NotSubsetExpr expr);
  
  visitSubsetExpr(SubsetExpr expr);
  
  visitUnionExpr(UnionExpr expr);
}