// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** Parses postfix operators like "!" */
class PostfixUnaryParselet implements InfixParselet {
  PostfixUnaryParselet(this.precedence);

  Expr parse(SolvrParser parser, Expr left, Token token) {
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
