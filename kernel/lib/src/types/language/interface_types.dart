// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

class InterfaceTypes {
  static const InterfaceType ALGEBRAIC_COLLECTION = const InterfaceType("AlgebraicCollection", EXPRESSION);
  static const InterfaceType COLLECTION = const InterfaceType("Collection");
  static const InterfaceType EXPRESSION = const InterfaceType("Expression");
}

/** Collections interface */
class CollectionsKeys {
  static const MethodType LENGTH = const MethodType("length", InterfaceTypes.COLLECTION, const [], ObjectTypes.NUMBER);
}
