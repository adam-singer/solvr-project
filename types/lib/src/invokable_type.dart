// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

/** Base class for all invokable types such as [FunctionType] and [MethodType] */
abstract class InvokableType extends IType {
  const InvokableType(this.simpleName, this.argumentTypes, this.returnType);

  final String simpleName;
  final List<IType> argumentTypes;
  final IType returnType;
}
