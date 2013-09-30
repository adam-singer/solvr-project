// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** Precedence values, ordered by increasing precedence */
class Precedence {
  static final int ASSIGNMENT  = 1;  // = : => | in
  static final int EQUALITY    = 2;  // == != is is!
  static final int LOGICAL_OR  = 3;  // ||
  static final int LOGICAL_AND = 4;  // &&
  static final int LOGICAL_NOT = 5;  // ! (negation)
  static final int COMPARISON  = 6;  // < > <= >= subset !subset
  static final int SUM         = 7;  // + - union complement
  static final int PRODUCT     = 8;  // * / . (dot product) intersect
  static final int EXPONENT    = 9;  // ^
  static final int PREFIX      = 10; // - (unary minus)
  static final int POSTFIX     = 11; // ! (factorial)
  static final int INVOKE      = 12; // f(...) list.length()
  static final int INTERVAL    = 13; // 10..100
  static final int LITERAL     = 14; // x, 12, true
  static final int GROUP       = 15; // () {} []
}
