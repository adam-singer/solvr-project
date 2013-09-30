// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

abstract class BinaryExprVisitor {
  // Algebraic expr
  visitComplexNumberExpr(ComplexNumberExpr expr);
  
  visitDifferenceExpr(DifferenceExpr expr);
  
  visitDotExpr(DotExpr expr);
  
  visitFractionExpr(FractionExpr expr);
  
  visitPowerExpr(PowerExpr expr);
  
  // Logical expr   
  visitAndExpr(AndExpr expr);
  
  visitOrExpr(OrExpr expr);
  
  // Object expr
  visitBindExpr(BindExpr expr);
  
  visitGuardExpr(GuardExpr expr);
  
  visitInstanceOfExpr(InstanceOfExpr expr);
  
  visitNotInstanceOfExpr(NotInstanceOfExpr expr);
  
  visitSubsitutionExpr(SubstitutionExpr expr);
  
  // Relational expressions 
  visitEqualExpr(EqualExpr expr);
  
  visitGreaterThanExpr(GreaterThanExpr expr);
  
  visitGreaterThanOrEqualExpr(GreaterThanOrEqualExpr expr);
  
  visitLessThanExpr(LessThanExpr expr);
  
  visitLessThanOrEqualExpr(LessThanOrEqualExpr expr);
  
  visitNotEqualExpr(NotEqualExpr expr);
  
  // Set expressions 
  visitComplementExpr(ComplementExpr expr);
  
  visitEntryExpr(EntryExpr expr);
  
  visitIntersectExpr(IntersectExpr expr);
  
  visitNotSubsetExpr(NotSubsetExpr expr);
  
  visitSubsetExpr(SubsetExpr expr);
  
  visitUnionExpr(UnionExpr expr);
}