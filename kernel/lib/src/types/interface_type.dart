// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

class InterfaceType extends SuperTypeable<InterfaceType> {
  // TODO change interface inheritance so a interface cannot implement other interfaces but can extend more than one supertype
  const InterfaceType(String interfaceName, [InterfaceType interfaceSuperType = null, this.interfaces = const []])
    : super(interfaceName, interfaceSuperType);

  final List<InterfaceType> interfaces;
}
