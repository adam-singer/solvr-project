// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_analyzer_internal;

/** Analyze [SpecialExpr] expressions for type correctness */
abstract class SpecialExprAnalyzer implements SpecialExprVisitor {
  @override
  visitAnonymousFunctionExpr(AnonymousFunctionExpr expr) => null;
 
  @override
  visitAssignExpr(AssignExpr expr) => null;
  
  @override
  visitBlockExpr(BlockExpr expr) => null;
  
  @override
  visitConditionalExpr(ConditionalExpr expr) => null;
  
  @override
  visitFunctionExpr(FunctionExpr expr) => null;
  
  @override
  visitInvokeExpr(InvokeExpr expr) => null;
  
  @override
  visitMethodExpr(MethodExpr expr) => null;
  
  @override
  visitNothingExpr(NothingExpr expr) => null;
  
  @override
  visitReturnExpr(ReturnExpr expr) => null;
  
  @override
  visitSeqExpr(SeqExpr expr) => null;
  
  @override
  visitTypedExpr(TypedExpr expr) => null;
  
  ExprVisitor get visitor;
}

/**
 * AnnonymousFunction check
  if(!args.every((e) => e is SymbolExpr)) {
    throw new ArgumentError("parameters for anonymous functions can only be symbols");
  }
*/