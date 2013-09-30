// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Class for all non object/interface/function/method/operator types (basically all statements) */
class LanguageType extends IType {
  const LanguageType(this.simpleName, [this.area = null]);

  String get qualifiedName => simpleName;

  final AreaType area;
  final String simpleName;
}
