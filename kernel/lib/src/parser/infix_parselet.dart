// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/**
 * An InfixParselet is associated with a token that appears in the middle of the
 * expression it parses. It's also used for postfix expressions, in
 * which case it simply doesn't consume any more tokens in its parse
 */
abstract class InfixParselet {
  Expr parse(InputParser parser, Expr left, Token token);

  int get precedence;
}
