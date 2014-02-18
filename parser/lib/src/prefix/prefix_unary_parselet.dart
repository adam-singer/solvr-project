// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** Parses prefix unary token's such as "-", "." and "!" */
class PrefixUnaryParselet implements PrefixParselet {
  PrefixUnaryParselet(this.precedence); 

  Expr parse(SolvrParser parser, Token token) {
    _logger.debug("parsing: ${token.value}");

    var left = parser.parseExpression(precedence);
    _logger.debug("left is $left");

    switch(token.type) {
    case SolvrTokens.BANG:
      return Expr.negationExpr(left, token.location);

    case SolvrTokens.DOT:
      if(isInteger(left)) {
        var str = "0.${left.toString()}";
        return Expr.realExpr(str, token.location);
      }
      throw new ParserError("prefix expression error for operator ${token.toString()}");

    case SolvrTokens.MINUS:
      return Expr.negativeExpr(left, token.location);

    default:
      throw new ParserError("prefix expression error for operator ${token.toString()}");
    }
  }
  
  final int precedence;
  static final _logger = LoggerFactory.getLoggerFor(PrefixUnaryParselet);
}
