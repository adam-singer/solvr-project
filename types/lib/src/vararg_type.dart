// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

/** Specialized type class for var args */
class VarargType extends IType {
  const VarargType(this.simpleName, this.bounds, this.minArgs);

  String get qualifiedName => simpleName;

  final int minArgs;
  final List<IType> bounds;
  final String simpleName;
}
