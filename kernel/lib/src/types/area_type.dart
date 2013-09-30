// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/**
 * Meta type designation used to group types
 *
 * TODO perhaps rename to PacakgeType or ModuleType ?
 */
class AreaType extends IType {
  const AreaType(this.simpleName, [ this.parentArea = null]);

  String get qualifiedName => simpleName;

  final String simpleName;
  final AreaType parentArea;
}

