// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/**
 * An InfixParselet is associated with a token that appears in the middle of the
 * expression it parses. It's also used for postfix expressions, in
 * which case it simply doesn't consume any more tokens in its parse
 */
abstract class InfixParselet {
  Expr parse(InputParser parser, Expr left, Token token);

  int get precedence;
}
