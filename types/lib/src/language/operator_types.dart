// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_types;

class OperatorTypes {
  static const ALGEBRAIC = const AreaType("Algebraic operator", AREA);
  static const LOGICAL = const AreaType("Logical operator", AREA);
  static const OBJECT = const AreaType("Algebraic operator", AREA);
  static const RELATIONAL = const AreaType("Relational operator", AREA);
  static const SET = const AreaType("Set operator", AREA);

  static const AREA = const AreaType("operator");
}

class BinaryOperators {
  // Binary algebraic operators
  static const COMPLEX = const OperatorType("Complex number", OperatorTypes.ALGEBRAIC, "+");
  static const DIFFERENCE = const OperatorType("Difference", OperatorTypes.ALGEBRAIC, "-");
  static const DOT = const OperatorType("Dot product", OperatorTypes.ALGEBRAIC, ".");
  static const FRACTION = const OperatorType("Fraction", OperatorTypes.ALGEBRAIC, "/");
  static const POWER = const OperatorType("Power", OperatorTypes.ALGEBRAIC, "^");
  // binary logical operators
  static const AND = const OperatorType("Logical conjunction", OperatorTypes.LOGICAL, "&&");
  static const OR = const OperatorType("Logical disjunction", OperatorTypes.LOGICAL, "||");
  // Binary object operators
  static const BIND = const OperatorType("In", OperatorTypes.OBJECT, "in");
  static const GUARD = const OperatorType("Guard", OperatorTypes.OBJECT, "|");
  static const INSTANCE = const OperatorType("Instance of", OperatorTypes.OBJECT, "is");
  static const NOT_INSTANCE = const OperatorType("Not instance of", OperatorTypes.OBJECT, "is!");
  static const SUBSTITUTION = const OperatorType("Substitution", OperatorTypes.OBJECT, ":=");
  // Binary relational operators
  static const EQUAL = const OperatorType("Equal", OperatorTypes.RELATIONAL, "==");
  static const GREATER = const OperatorType("Greater than", OperatorTypes.RELATIONAL, ">");
  static const GREATER_OR_EQUAL = const OperatorType("Greater than or equal", OperatorTypes.RELATIONAL, ">=");
  static const LESS = const OperatorType("Less than", OperatorTypes.RELATIONAL, "<");
  static const LESS_OR_EQUAL = const OperatorType("Less than or equal", OperatorTypes.RELATIONAL, "<=");
  static const NOT_EQUAL = const OperatorType("Not equal", OperatorTypes.RELATIONAL, "!=");
  // Binary set operators
  static const COMPLEMENT = const OperatorType("Complement", OperatorTypes.SET, r"\");
  static const ENTRY = const OperatorType("Entry", OperatorTypes.SET, ":");
  static const INTERSECT = const OperatorType("Intersection", OperatorTypes.SET, "intersect");
  static const SUBSET = const OperatorType("subset", OperatorTypes.SET, "subset");
  static const NOT_SUBSET = const OperatorType("Not subset", OperatorTypes.SET, "!subset");
  static const UNION = const OperatorType("Union", OperatorTypes.SET, "union");
}

class UnaryOperators {
  // Unary algebraic operators
  static const FACTORIAL = const OperatorType("Factorial", OperatorTypes.ALGEBRAIC, "!");
  static const NEGATIVE = const OperatorType("Negative", OperatorTypes.ALGEBRAIC, "-");
  // Unary logical operators
  static const NEGATION = const OperatorType("Negation", OperatorTypes.LOGICAL, "!");
}

class NaryOperators {
  // Nary algebraic operators
  static const PRODUCT = const OperatorType("Product", OperatorTypes.ALGEBRAIC, "*");
  static const SUM = const OperatorType("Sum", OperatorTypes.ALGEBRAIC, "+");
}

