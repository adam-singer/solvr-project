// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

/** Commonly used var and generic argument types */
class HelperTypes {
  static const MIN_TWO_NUMBERS = const VarargType("Minimum two numbers", const [ObjectTypes.NUMBER], 2);

  static const LIST_OF_EXPRESSIONS = const GenericType("List of expressions", ObjectTypes.LIST, InterfaceTypes.EXPRESSION);

  static const LIST_OF_SUBSTITUTION = const GenericType("List of substitutions", ObjectTypes.LIST, BinaryOperators.SUBSTITUTION);

  static const SET_OF_SUBSTITUTION = const GenericType("Set of substitutions", ObjectTypes.SET, BinaryOperators.SUBSTITUTION);
}
