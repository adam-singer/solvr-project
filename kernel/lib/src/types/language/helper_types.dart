// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_types;

/** Commonly used var and generic argument types */
class HelperTypes {
  static const MIN_TWO_NUMBERS = const VarargType("Minimum two numbers", const [ObjectTypes.NUMBER], 2);

  static const LIST_OF_EXPRESSIONS = const GenericType("List of expressions", ObjectTypes.LIST, InterfaceTypes.EXPRESSION);

  static const LIST_OF_SUBSTITUTION = const GenericType("List of substitutions", ObjectTypes.LIST, BinaryOperators.SUBSTITUTION);

  static const SET_OF_SUBSTITUTION = const GenericType("Set of substitutions", ObjectTypes.SET, BinaryOperators.SUBSTITUTION);
}
