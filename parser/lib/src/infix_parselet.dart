// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/**
 * An [InfixParselet]'s parses tokens that appears in the middle of expressions 
 * 
 * It's also used for postfix expressions, since these can be viewed as a infix 
 * expression with nothing on the left, followed by the postfix operator and its 
 * operand.
 */
abstract class InfixParselet {
  Expr parse(SolvrParser parser, Expr left, Token token);

  int get precedence;
}
