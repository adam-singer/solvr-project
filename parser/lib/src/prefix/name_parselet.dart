// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** Parses names, such as symbols, generics and method invocations */
class NameParselet implements PrefixParselet {
  Expr parse(SolvrParser parser, Token token) {
    _logger.debug('parsing: ${token.value}');
    final String name = token.value;

    if(parser.consumeImmediateMatch(SolvrTokens.LEFT_PAREN)) {
      var args = parser.parseTuple();
      if(!isTuple(args)) throw new ParserError('expected tuple found $args');

      // check to see if its a invocation or a function declaration
      if(parser.lookAheadFor(SolvrTokens.LEFT_BRACE)) {
        var body = parser.parseBlock();
        return Expr.functionExpr(name, args, body, token.location);
      } else {
        // A symbol followed immediatly by a tuple such as (), (expr), (expr1, expr2, ...)
        // is treated as a function call
        return parser.checkForProduct(Expr.invokeExpr(name, args, token.location));
      }
    } else {
      var res = _makeSymbol(token);

      if(parser.isObjectType(res)) {
        // check to see if we have a typed expression like
        // - String str...
        // - Number f(x)...
        if(parser.lookAheadFor(SolvrTokens.NAME)) {
          var span = parser.span();
          Expr declaration = parser.parseExpression();

          res = Expr.typedExpr(res, declaration, span.end());
          _logger.debug('parsed typed expression $res');
        }
      } else {
        _logger.debug('parsed symbol $res');
      }

      return res;
    }
  }

  SymbolExpr _makeSymbol(Token token) => Expr.symbolExpr(token.value, token.location);
  
  static final _logger = LoggerFactory.getLoggerFor(NameParselet);
}
