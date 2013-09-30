// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/** Parses the assignment operator = */
class AssignParselet implements InfixParselet {
  Expr parse(InputParser parser, var left, Token token) {
    _logger.debug('parsing: ${token.value}');

    switch(token.type) {
      case TokenType.ASSIGN:
        if(isInvoke(left)) {
          // single line function declaration fx f(x) = x^2
          Expr body = parser.parseExpression();
          return Expr.functionExpr(token.position, left.name, left.args, body);
        } else if(isSymbol(left)) {
          // variable assignment fx x = 24
          Expr value = parser.parseExpression();
          return Expr.assignExpr(token.position, left, value);
        }
        break;

      case TokenType.SUBSTITUTION:
        Expr value = parser.parseExpression();
        return Expr.substitutionExpr(token.position, left, value);

      case TokenType.LEFT_ARROW:
        if(isTuple(left)) {
          // anonymous function declaration fx (x) => x^2
          var body = parser.parseExpression();
          return Expr.anonymousFunctionExpr(token.position, left, body);
        }
        break;        
    }
    throw new ParserError('assignment expression error for expression ${left.toString()}');
  }
  
  final int precedence = Precedence.ASSIGNMENT;
  static final _logger = LoggerFactory.getLoggerFor(AssignParselet);
}
