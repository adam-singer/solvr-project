// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** Parses touples such as (a), (a + b) and (a+b)(c+d). */
class TupleParselet implements PrefixParselet {
  Expr parse(InputParser parser, Token token) {
    _logger.debug("parsing: ${token.value}");
    return parser.checkForProduct(parser.parseTuple());
  }
  
  static final Logger _logger = LoggerFactory.getLoggerFor(TupleParselet);
}
