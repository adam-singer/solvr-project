// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/// error for invocations whose results are mathematically undefined
class ExprInvocationUndefinedError extends ExprError {
  ExprInvocationUndefinedError(String errorMessage): super(errorMessage, null);
}

/// error for expressions that are mathematically undefined, like division by zero
class ExprUndefinedError extends ExprError {
  ExprUndefinedError(String errorMessage, Expr expr): super(errorMessage, expr);
  
  String toString() => "Undefined expression: $errorMessage at position $errorPosition";
}

/// error for expressions that have no handlers registred 
class ExprUnhandledError extends ExprError {
  ExprUnhandledError(String errorMessage, Expr expr): super(errorMessage, expr);
  
  ExprUnhandledError.expr(Expr expr): this("Unhandled expression ${expr} at position ${expr.position}", expr);
}

/// error when arguments for expressions are wrong
class ExprArgumentError extends ExprError {
  ExprArgumentError(String errorMessage, Expr expr): super(errorMessage, expr);
} 

/// errors involving [Expr]
abstract class ExprError extends SolvrError {
  ExprError(this.errorMessage, this.expr);
  
  Position get errorPosition => expr.position;
  
  // expr is not final as it might not always be possible to resolve it from deep function calls
  Expr expr;
  final String errorMessage;
}