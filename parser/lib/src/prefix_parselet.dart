// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** A prefix parselet is associated with a token that appears at the beginning of an expression. */
abstract class PrefixParselet {
  Expr parse(InputParser parser, Token token);
}
