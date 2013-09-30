// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Type for all operators such as +, -, ... */
class OperatorType extends IType {
  const OperatorType(this.qualifiedName, this.area, this.simpleName);

  final String qualifiedName;
  final AreaType area;
  /// Operator symbol
  final String simpleName;
}

bool isOperator(IType type) => type is OperatorType;
