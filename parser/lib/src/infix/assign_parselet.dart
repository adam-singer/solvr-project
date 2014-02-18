// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** Parses the assignment operator = */
class AssignParselet implements InfixParselet {
  Expr parse(SolvrParser parser, var left, Token token) {
    _logger.debug('parsing: ${token.value}');

    switch(token.type) {
      case SolvrTokens.ASSIGN:
        if(isInvoke(left)) {
          // single line function declaration fx f(x) = x^2
          Expr body = parser.parseExpression();
          return Expr.functionExpr(left.name, left.args, body, token.location);
        } else if(isSymbol(left)) {
          // variable assignment fx x = 24
          Expr value = parser.parseExpression();
          return Expr.assignExpr(left, value, token.location);
        }
        break;

      case SolvrTokens.SUBSTITUTION:
        Expr value = parser.parseExpression();
        return Expr.substitutionExpr(left, value, token.location);

      case SolvrTokens.LEFT_ARROW:
        if(isTuple(left)) {
          // anonymous function declaration fx (x) => x^2
          var body = parser.parseExpression();
          return Expr.anonymousFunctionExpr(left, body, token.location);
        }
        break;        
    }
    throw new ParserError('assignment expression error for expression ${left.toString()}');
  }
  
  final int precedence = SolvrPrecedence.ASSIGNMENT;
  static final _logger = LoggerFactory.getLoggerFor(AssignParselet);
}
