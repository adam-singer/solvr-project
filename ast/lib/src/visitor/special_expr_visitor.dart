// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Visit special expressions (i.e. expressions that are not simple nullary/unary/binary) */
abstract class SpecialExprVisitor {
  visitAnonymousFunctionExpr(AnonymousFunctionExpr expr);
  
  visitAssignExpr(AssignExpr expr);
  
  visitBlockExpr(BlockExpr expr);
  
  visitConditionalExpr(ConditionalExpr expr);
  
  visitFunctionExpr(FunctionExpr expr);
  
  visitGenericExpr(GenericExpr expr);
  
  visitInvokeExpr(InvokeExpr expr);
  
  visitMethodExpr(MethodExpr expr);
  
  visitNothingExpr(NothingExpr expr);
  
  visitReturnExpr(ReturnExpr expr);
  
  visitSeqExpr(SeqExpr expr);
  
  visitTypedExpr(TypedExpr expr);
}