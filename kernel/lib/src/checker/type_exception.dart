// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_checker;

class TypeException implements Exception {
  final List<String> _errors;
  final Expr _expression;

  const TypeException(this._expression, this._errors);

  String toString() => "type errors: $_errors in expression: $_expression";
}
