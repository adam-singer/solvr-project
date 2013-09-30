// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/** Parses touples such as (a), (a + b) and (a+b)(c+d). */
class TupleParselet implements PrefixParselet {
  Expr parse(InputParser parser, Token token) {
    _logger.debug("parsing: ${token.value}");
    return parser.checkForProduct(parser.parseTuple());
  }
  
  static final Logger _logger = LoggerFactory.getLoggerFor(TupleParselet);
}
