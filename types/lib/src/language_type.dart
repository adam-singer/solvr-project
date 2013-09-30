// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

/** Class for all non object/interface/function/method/operator types (basically all statements) */
class LanguageType extends IType {
  const LanguageType(this.simpleName, [this.area = null]);

  String get qualifiedName => simpleName;

  final AreaType area;
  final String simpleName;
}
