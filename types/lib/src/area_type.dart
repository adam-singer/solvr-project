// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

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

