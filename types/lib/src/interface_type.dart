// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

class InterfaceType extends SuperTypeable<InterfaceType> {
  // TODO change interface inheritance so a interface cannot implement other interfaces but can extend more than one supertype
  const InterfaceType(String interfaceName, [InterfaceType interfaceSuperType = null, this.interfaces = const []])
    : super(interfaceName, interfaceSuperType);

  final List<InterfaceType> interfaces;
}
