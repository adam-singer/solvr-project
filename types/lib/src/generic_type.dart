// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.ed.

part of solvr_types;

/** Type for generic types such as List<String> */
class GenericType extends ObjectType {
  const GenericType(String genericName, this.template, this.boundary, [ObjectType objectSuperType = null, List<InterfaceType> interfaces = const []])
    : super(genericName, objectSuperType, interfaces);

  final IType template;
  final IType boundary;
}

bool isGenericType(var type) => type is GenericType;
