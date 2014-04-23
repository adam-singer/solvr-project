// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_analyzer_internal;

/** Analyze [BinaryExpr] expressions for type correctness */
abstract class BinaryExprAnalyzer implements BinaryExprVisitor {
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
  
  bool _isOperandsAlgebraic(BinaryExpr expr) {
    expr.operands.forEach((Expr operand) {
      if(isAlgebraic(operand)) {
          errorContext.error("algebraic operator ${expr.token} cannot be applied to operand ${operand}");
        }
    });
    return null;
  }
  
  _checkBinary(var expr) {
       if(expr.operands.every(isAlgebraicCollection)) {
         _checkAlgebraicCollectionExpressions(expr);
      }
    }
  
  // TODO fix this, perhaps add generics to BinaryExpr (i.e. BinaryExpr<AlgebraicCollection, AlgebraicCollection>)
  _checkAlgebraicCollectionExpressions(BinaryExpr expr) {
   var u1 = expr.left;
   var u2 = expr.right;
   // equal collection types can only be combined if they have the same cardinality
   if(u1.type == u2.type && u1.length != u2.length) {
     error("cannot apply ${expr.token} to unequal length $u1 and $u2");
   }
  }
  
  _checkRelationalExpressions(var expr) {
    if(!expr.anyOf([isEqual, isNotEqual])) {
      expr.operands.forEach((Expr operand) {
        // TODO infer operand (i.e. handle functions)
        if(!isAlgebraic(operand)) {
          error("relational operator ${expr.token} cannot be applied to operand ${operand}");
        }
      });
    }
  }
  
  _checkSetExpressions(Expr expr) {
     if(isEntry(expr)) {
       // only allow for dictionaries or as named arguments to methods/functions
       if(!(_inDictionary(expr) || _inFunction(expr) || _inMethod(expr))) {
         error("illegal use of entry expression $expr");
       }
     } else {
       // the rest can only be applied to set on both their left and right side
       expr.operands.forEach((Expr operand) {
         if(!isSet(operand)) {
           error("set operator ${expr.type} cannot be applied to ${operand}");
         }
       });
     }
   }

   bool _inDictionary(Expr expr) => expr.parentsAre([isDictionary]);

   bool _inFunction(Expr expr) => expr.parentsAre([isTuple, isInvoke]);

   bool _inMethod(Expr expr) => expr.parentsAre([isTuple, isMethod]);
  
  ErrorContext get errorContext;
  
  ExprVisitor get visitor;
}