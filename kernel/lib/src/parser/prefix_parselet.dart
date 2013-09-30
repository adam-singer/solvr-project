// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/**
 * A prefix parselet is associated with a token that appears at the beginning of an expression.
 */
abstract class PrefixParselet {
  Expr parse(InputParser parser, Token token);
}
