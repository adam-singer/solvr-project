// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/** parses token literal's such as 1, 2, 3, TRUE, ... */
class NullaryParselet implements PrefixParselet {
  Expr parse(InputParser parser, Token token) {
    _logger.debug("parsing: ${token.value}");

    switch(token.type) {
    case TokenType.BOOL:
      return Expr.boolExpr(token.position, token.value);

    case TokenType.NUMBER:
      var number;
      if(token.value.contains(r".")) {
        number = Expr.realExpr(token.position, token.value);
      } else {
        number = Expr.numberExpr(token.position, token.value);
      }
      // check for cases such as 2(x+3)
      return parser.checkForProduct(number);

    case TokenType.STRING:
      return Expr.stringExpr(token.position, token.value);

    default:
      throw new ParserError("literal expression error for ${token.toString()}");
    }
  }
  
  static final _logger = LoggerFactory.getLoggerFor(NullaryParselet);
}
