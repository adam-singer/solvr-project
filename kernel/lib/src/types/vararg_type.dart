// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Specialized type class for var args */
class VarargType extends IType {
  const VarargType(this.simpleName, this.bounds, this.minArgs);

  String get qualifiedName => simpleName;

  final int minArgs;
  final List<IType> bounds;
  final String simpleName;
}
