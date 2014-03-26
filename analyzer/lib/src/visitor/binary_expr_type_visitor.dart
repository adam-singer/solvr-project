// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_type_checker;

abstract class BinaryExprTypeVisitor implements BinaryExprVisitor {
  @override
  visitComplexNumberExpr(ComplexNumberExpr expr) => null;
  
  @override
  visitDifferenceExpr(DifferenceExpr expr) => null;
  
  @override
  visitDotExpr(DotExpr expr) => null;
  
  @override
  visitFractionExpr(FractionExpr expr) => null;
  
  @override
  visitPowerExpr(PowerExpr expr) => null;
  
  @override
  visitAndExpr(AndExpr expr) => null;
  
  @override
  visitOrExpr(OrExpr expr) => null;
  
  @override
  visitBindExpr(BindExpr expr) => null;
  
  @override
  visitGuardExpr(GuardExpr expr) => null;
  
  @override
  visitInstanceOfExpr(InstanceOfExpr expr) => null;
  
  @override
  visitNotInstanceOfExpr(NotInstanceOfExpr expr) => null;
  
  @override
  visitSubsitutionExpr(SubstitutionExpr expr) => null;
  
  @override
  visitEqualExpr(EqualExpr expr) => null;
  
  @override
  visitGreaterThanExpr(GreaterThanExpr expr) => null;
  
  @override
  visitGreaterThanOrEqualExpr(GreaterThanOrEqualExpr expr) => null;
  
  @override
  visitLessThanExpr(LessThanExpr expr) => null; 
  
  @override
  visitLessThanOrEqualExpr(LessThanOrEqualExpr expr) => null;
  
  @override
  visitNotEqualExpr(NotEqualExpr expr) => null;
  
  @override
  visitComplementExpr(ComplementExpr expr) => null;
  
  @override
  visitEntryExpr(EntryExpr expr) => null;
  
  @override
  visitIntersectExpr(IntersectExpr expr) => null;
  
  @override
  visitNotSubsetExpr(NotSubsetExpr expr) => null;
  
  @override
  visitSubsetExpr(SubsetExpr expr) => null;
  
  @override
  visitUnionExpr(UnionExpr expr) => null;
  
  ExprVisitor get visitor;
}