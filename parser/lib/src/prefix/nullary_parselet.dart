// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** parses token literal's such as 1, 2, 3, TRUE, ... */
class NullaryParselet implements PrefixParselet {
  Expr parse(SolvrParser parser, Token token) {
    _logger.debug("parsing: ${token.value}");

    switch(token.type) {
    case SolvrTokens.BOOL:
      return Expr.boolExpr(token.value, token.location);

    case SolvrTokens.NUMBER:
      var number;
      if(token.value.contains(r".")) {
        number = Expr.realExpr(token.value, token.location);
      } else {
        number = Expr.integerExpr(token.value, token.location);
      }
      // check for cases such as 2(x+3)
      return parser.checkForProduct(number);

    case SolvrTokens.STRING:
      return Expr.stringExpr(token.value, token.location);

    default:
      throw new ParserError("nullary expression error for ${token.toString()}");
    }
  }
  
  static final _logger = LoggerFactory.getLoggerFor(NullaryParselet);
}
