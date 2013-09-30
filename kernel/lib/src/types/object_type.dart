// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Type for all objects such as Strings, Lists, ...*/
class ObjectType extends SuperTypeable<ObjectType> {
  const ObjectType(String objectName, [ObjectType objectSuperType = null, this.interfaces = const []])
    : super(objectName, objectSuperType);

  final List<InterfaceType> interfaces;
}
