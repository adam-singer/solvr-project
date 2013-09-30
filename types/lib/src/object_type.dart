// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

/** Type for all objects such as Strings, Lists, ...*/
class ObjectType extends SuperTypeable<ObjectType> {
  const ObjectType(String objectName, [ObjectType objectSuperType = null, this.interfaces = const []])
    : super(objectName, objectSuperType);

  final List<InterfaceType> interfaces;
}
