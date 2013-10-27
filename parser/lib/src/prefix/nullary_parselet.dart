// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** parses token literal's such as 1, 2, 3, TRUE, ... */
class NullaryParselet implements PrefixParselet {
  Expr parse(SolvrParser parser, Token token) {
    _logger.debug("parsing: ${token.value}");

    switch(token.type) {
    case TokenType.BOOL:
      return Expr.boolExpr(token.position, token.value);

    case TokenType.NUMBER:
      var number;
      if(token.value.contains(r".")) {
        number = Expr.realExpr(token.position, token.value);
      } else {
        number = Expr.integerExpr(token.position, token.value);
      }
      // check for cases such as 2(x+3)
      return parser.checkForProduct(number);

    case TokenType.STRING:
      return Expr.stringExpr(token.position, token.value);

    default:
      throw new ParserError("nullary expression error for ${token.toString()}");
    }
  }
  
  static final _logger = LoggerFactory.getLoggerFor(NullaryParselet);
}
