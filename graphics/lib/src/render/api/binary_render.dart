// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render;

abstract class BinaryRender {
  // Algebraic expressions 
  renderDifference(DifferenceExpr expr);
  
  renderDot(DotExpr expr);
  
  renderFraction(FractionExpr expr);
  
  renderPower(PowerExpr expr);
  
  // Logical expressions 
  renderAnd(AndExpr expr);
  
  renderOr(OrExpr expr);
  
  // Object expressions 
  // TODO -
  
  // Relational expressions 
  renderEqual(EqualExpr expr);
  
  renderGreaterThan(GreaterThanExpr expr);
  
  renderGreaterThanOrEqual(GreaterThanOrEqualExpr expr);
  
  renderLessThan(LessThanExpr expr);
  
  renderLessThanOrEqual(LessThanOrEqualExpr expr);
  
  renderNotEqual(NotEqualExpr expr);
  
  // Set expressions 
  renderComplement(ComplementExpr expr);
  
  renderIntersect(IntersectExpr expr);
  
  renderNotSubset(NotSubsetExpr expr);
  
  renderSubset(SubsetExpr expr);
  
  renderUnion(UnionExpr expr);
}
