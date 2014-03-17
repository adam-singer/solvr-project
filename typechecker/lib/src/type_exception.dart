// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_type_checker;

class TypeException implements Exception {
  final List<String> _errors;
  final Expr _expression;

  const TypeException(this._expression, this._errors);

  String toString() => "type errors: $_errors in expression: $_expression";
}
