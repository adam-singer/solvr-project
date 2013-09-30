// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/** Parses postfix operators like "!" */
class PostfixUnaryParselet implements InfixParselet {
  PostfixUnaryParselet(this.precedence);

  Expr parse(InputParser parser, Expr left, Token token) {
    _logger.debug("parsing: ${token.value}");

    switch(token.type) {
    case TokenType.BANG:
      // check for cases (2+3)!(x*2)
      return parser.checkForProduct(Expr.factorialExpr(token.position, left));
    default:
      throw new ParserError("postfix expression error for operator ${token.toString()}");
    }
  }
  
  final int precedence;
  static final Logger _logger = LoggerFactory.getLoggerFor(PostfixUnaryParselet);
}
