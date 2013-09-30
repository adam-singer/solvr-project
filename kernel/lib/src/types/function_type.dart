// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Type for functions */
class FunctionType extends InvokableType {
  const FunctionType(String simpleName, List<IType> argumentTypes, IType returnType, this.area)
    : super(simpleName, argumentTypes, returnType);

  // TODO use argument types and area in name also
  String get qualifiedName => simpleName;

  final AreaType area;
}


