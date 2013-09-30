// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

class InterfaceTypes {
  static const InterfaceType ALGEBRAIC_COLLECTION = const InterfaceType("AlgebraicCollection", EXPRESSION);
  static const InterfaceType COLLECTION = const InterfaceType("Collection");
  static const InterfaceType EXPRESSION = const InterfaceType("Expression");
}

/** Collections interface */
class CollectionsKeys {
  static const MethodType LENGTH = const MethodType("length", InterfaceTypes.COLLECTION, const [], ObjectTypes.NUMBER);
}
