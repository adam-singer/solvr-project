// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/// error for invocations whose results are mathematically undefined
class ExprInvocationUndefinedError extends ExprError {
  ExprInvocationUndefinedError(String errorMessage): super(errorMessage, null);
}

/// error for expressions that are mathematically undefined, like division by zero
class ExprUndefinedError extends ExprError {
  ExprUndefinedError(String errorMessage, Expr expr): super(errorMessage, expr);
  
  String toString() => "Undefined expression: $errorMessage at location $errorLocation";
}

/// error for expressions that have no handlers registred 
class ExprUnhandledError extends ExprError {
  ExprUnhandledError(String errorMessage, Expr expr): super(errorMessage, expr);
  
  ExprUnhandledError.expr(Expr expr): this("Unhandled expression ${expr} at location ${expr.location}", expr);
}

/// error when arguments for expressions are wrong
class ExprArgumentError extends ExprError {
  ExprArgumentError(String errorMessage, Expr expr): super(errorMessage, expr);
} 

/// errors involving [Expr]
abstract class ExprError extends SolvrError {
  ExprError(this.errorMessage, this.expr);
  
  Location get errorLocation => expr.location;
  
  // expr is not final as it might not always be possible to resolve it from deep function calls
  Expr expr;
  final String errorMessage;
}