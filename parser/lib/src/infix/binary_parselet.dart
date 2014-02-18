// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** parses binary operators like '+', '-', '*', '/', and '^' (i.e. 2^8) */
class BinaryParselet implements InfixParselet {
  BinaryParselet(this.precedence, this.isRight);

  Expr parse(SolvrParser parser, Expr left, Token token) {
    _logger.debug('parsing: ${token.value}');

    // To handle right-associative operators like '^', we allow a slightly
    // lower precedence when parsing the right-hand side. This will let a
    // parselet with the same precedence appear on the right, which will then
    // take *this* parselet's result as its left-hand argument.
    int rightPrecedence = precedence - (isRight ? 1 : 0);
    Expr right = parser.parseExpression(rightPrecedence);

    switch(token.type) {
    case SolvrTokens.ASTERISK:
      return Expr.productExpr(left, right, token.location);

    case SolvrTokens.BACK_SLASH:
      return Expr.complementExpr(left, right, token.location);

    case SolvrTokens.COLON:
      return Expr.entryExpr(left, right, token.location);

    case SolvrTokens.CARET:
      return Expr.powerExpr(left, right, token.location);

    case SolvrTokens.DOT:
      return Expr.dotExpr(left, right, token.location);

    case SolvrTokens.DOTS:
      Expr step = null;
      if(parser.consumeMatch(SolvrTokens.DOTS)) {
        // Handle case where a step is invovled i.e. 1..2..10
        step = right;
        right = parser.parseExpression();
      }
      if(step == null) {
        step = Expr.nothingExpr(parser.last().location);
      }
      return Expr.intervalExpr(left, step, right, token.location);

    case SolvrTokens.EQUAL:
      return Expr.equalExpr(left, right, token.location);

    case SolvrTokens.GREATER_THAN:
      var greaterThan = Expr.greaterThanExpr(left, right, token.location);
      return parser.checkForAnd(greaterThan);

    case SolvrTokens.GREATER_THAN_OR_EQUAL:
      var greaterThanOrEqual = Expr.greaterThanOrEqualExpr(left, right, token.location);
      return parser.checkForAnd(greaterThanOrEqual);

    case SolvrTokens.IN:
      return Expr.bindExpr(left, right, token.location);

    case SolvrTokens.INSTANCE_OF:
      return Expr.instanceOfExpr(left, right, token.location);

    case SolvrTokens.INTERSECT:
      return Expr.intersectExpr(left, right, token.location);

    case SolvrTokens.LESS_THAN:
      var lessThan = Expr.lessThanExpr(left, right, token.location);
      return parser.checkForAnd(lessThan);

    case SolvrTokens.LESS_THAN_OR_EQUAL:
      var lessThanOrEqual = Expr.lessThanOrEqualExpr(left, right, token.location);
      return parser.checkForAnd(lessThanOrEqual);

    case SolvrTokens.LOGICAL_AND:
      return Expr.andExpr(left, right, token.location);

    case SolvrTokens.LOGICAL_OR:
      return Expr.orExpr(left, right, token.location);

    case SolvrTokens.MINUS:
      return Expr.differenceExpr(left, right, token.location);

    case SolvrTokens.NOT_EQUAL:
      return Expr.notEqualExpr(left, right, token.location);

    case SolvrTokens.NOT_SUBSET:
      return Expr.notSubsetExpr(left, right, token.location);

    case SolvrTokens.NOT_INSTANCE_OF:
      return Expr.notInstanceOfExpr(left, right, token.location);

    case SolvrTokens.PIPE:
      return Expr.guardExpr(left, right, token.location);

    case SolvrTokens.PLUS:
      return Expr.sumExpr(left, right, token.location);

    case SolvrTokens.SLASH:
      return Expr.fractionExpr(left, right, token.location);

    case SolvrTokens.SUBSET:
      return Expr.subsetExpr(left, right, token.location);

    case SolvrTokens.UNION:
      return Expr.unionExpr(left, right, token.location);

    default:
      throw new ParserError('binary expression error for operator ${token.toString()}');
    }
  }
  
  final int precedence;
  final bool isRight;
  static final _logger = LoggerFactory.getLoggerFor(BinaryParselet);
}

