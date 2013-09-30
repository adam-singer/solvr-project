// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

/** Type for all operators such as +, -, ... */
class OperatorType extends IType {
  const OperatorType(this.qualifiedName, this.area, this.simpleName);

  final String qualifiedName;
  final AreaType area;
  /// Operator symbol
  final String simpleName;
}

bool isOperator(IType type) => type is OperatorType;
