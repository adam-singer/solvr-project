// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Type for generic types such as List<String> */
class GenericType extends ObjectType {
  const GenericType(String genericName, this.template, this.boundary, [ObjectType objectSuperType = null, List<InterfaceType> interfaces = const []])
    : super(genericName, objectSuperType, interfaces);

  final IType template;
  final IType boundary;
}

bool isGenericType(var type) => type is GenericType;
