// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Base class for all invokable types such as [FunctionType] and [MethodType] */
abstract class InvokableType extends IType {
  const InvokableType(this.simpleName, this.argumentTypes, this.returnType);

  final String simpleName;
  final List<IType> argumentTypes;
  final IType returnType;
}
