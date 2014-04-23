// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

/** Type for object methods */
class MethodType extends InvokableType {
  const MethodType(String simpleName, this.target): super(simpleName);

  String get qualifiedName => "${target.qualifiedName}.${simpleName}";

  final SuperTypeable target;
}


