// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/** Parses prefix unary token's such as "-", "." and "!" */
class PrefixUnaryParselet implements PrefixParselet {
  PrefixUnaryParselet(this.precedence); 

  Expr parse(InputParser parser, Token token) {
    _logger.debug("parsing: ${token.value}");

    var left = parser.parseExpression(precedence);
    _logger.debug("left is $left");

    switch(token.type) {
    case TokenType.BANG:
      return Expr.negationExpr(token.position, left);

    case TokenType.DOT:
      if(isInteger(left)) {
        var str = "0.${left.toString()}";
        return Expr.realExpr(token.position, str);
      }
      // TODO figure out how to fall through
      throw new ParserError("prefix expression error for operator ${token.toString()}");

    case TokenType.MINUS:
      return Expr.negativeExpr(token.position, left);

    default:
      throw new ParserError("prefix expression error for operator ${token.toString()}");
    }
  }
  
  final int precedence;
  static final _logger = LoggerFactory.getLoggerFor(PrefixUnaryParselet);
}
