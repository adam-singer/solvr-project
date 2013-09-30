// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Type for object methods */
class MethodType extends InvokableType {
  const MethodType(String simpleName, this.target, List<IType> argumentTypes, IType returnType)
    : super(simpleName, argumentTypes, returnType);

  String get qualifiedName => "${target.qualifiedName}.${simpleName}";

  final SuperTypeable target;
}


