// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/** parses binary operators like '+', '-', '*', '/', and '^' (i.e. 2^8) */
class BinaryParselet implements InfixParselet {
  BinaryParselet(this.precedence, this.isRight);

  Expr parse(InputParser parser, Expr left, Token token) {
    _logger.debug('parsing: ${token.value}');

    // To handle right-associative operators like '^', we allow a slightly
    // lower precedence when parsing the right-hand side. This will let a
    // parselet with the same precedence appear on the right, which will then
    // take *this* parselet's result as its left-hand argument.
    int rightPrecedence = precedence - (isRight ? 1 : 0);
    Expr right = parser.parseExpression(rightPrecedence);

    switch(token.type) {
    case TokenType.ASTERISK:
      return Expr.productExpr(token.position, left, right);

    case TokenType.BACK_SLASH:
      return Expr.complementExpr(token.position, left, right);

    case TokenType.COLON:
      return Expr.entryExpr(token.position, left, right);

    case TokenType.CARET:
      return Expr.powerExpr(token.position, left, right);

    case TokenType.DOT:
      return Expr.dotExpr(token.position, left, right);

    case TokenType.DOTS:
      Expr step = null;
      if(parser.consumeMatch(TokenType.DOTS)) {
        // Handle case where a step is invovled i.e. 1..2..10
        step = right;
        right = parser.parseExpression();
      }
      if(step == null) {
        step = Expr.nothingExpr(parser.last().position);
      }
      return Expr.intervalExpr(token.position, left, step, right);

    case TokenType.EQUAL:
      return Expr.equalExpr(token.position, left, right);

    case TokenType.GREATER_THAN:
      var greaterThan = Expr.greaterThanExpr(token.position, left, right);
      return parser.checkForAnd(greaterThan);

    case TokenType.GREATER_THAN_OR_EQUAL:
      var greaterThanOrEqual = Expr.greaterThanOrEqualExpr(token.position, left, right);
      return parser.checkForAnd(greaterThanOrEqual);

    case TokenType.IN:
      return Expr.bindExpr(token.position, left, right);

    case TokenType.INSTANCE_OF:
      return Expr.instanceOfExpr(token.position, left, right);

    case TokenType.INTERSECT:
      return Expr.intersectExpr(token.position, left, right);

    case TokenType.LESS_THAN:
      var lessThan = Expr.lessThanExpr(token.position, left, right);
      return parser.checkForAnd(lessThan);

    case TokenType.LESS_THAN_OR_EQUAL:
      var lessThanOrEqual = Expr.lessThanOrEqualExpr(token.position, left, right);
      return parser.checkForAnd(lessThanOrEqual);

    case TokenType.LOGICAL_AND:
      return Expr.andExpr(token.position, left, right);

    case TokenType.LOGICAL_OR:
      return Expr.orExpr(token.position, left, right);

    case TokenType.MINUS:
      return Expr.differenceExpr(token.position, left, right);

    case TokenType.NOT_EQUAL:
      return Expr.notEqualExpr(token.position, left, right);

    case TokenType.NOT_SUBSET:
      return Expr.notSubsetExpr(token.position, left, right);

    case TokenType.NOT_INSTANCE_OF:
      return Expr.notInstanceOfExpr(token.position, left, right);

    case TokenType.PIPE:
      return Expr.guardExpr(token.position, left, right);

    case TokenType.PLUS:
      return Expr.sumExpr(token.position, left, right);

    case TokenType.SLASH:
      return Expr.fractionExpr(token.position, left, right);

    case TokenType.SUBSET:
      return Expr.subsetExpr(token.position, left, right);

    case TokenType.UNION:
      return Expr.unionExpr(token.position, left, right);

    default:
      throw new ParserError('binary expression error for operator ${token.toString()}');
    }
  }
  
  final int precedence;
  final bool isRight;
  static final _logger = LoggerFactory.getLoggerFor(BinaryParselet);
}

