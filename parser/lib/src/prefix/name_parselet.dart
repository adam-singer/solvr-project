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
        if(parser.consumeMatch(SolvrTokens.LESS_THAN)) {
          res = _parseGeneric(parser, res);
          _logger.debug('parsed generic expression $res');
        }
        // check to see if we have a typed expression like
        // - String str...
        // - List<String> f(x)...
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

  /*
   * Handle generics like
   * - Set<String>
   * - List<Set<Symbol>>
   */
  GenericExpr _parseGeneric(SolvrParser parser, SymbolExpr template) {
    var span = parser.span();
    // Generics such as 'a<b> c' can be recognized from ordinary logical expressions like 'a<b && b>c' by
    // - has the form: "typeName<typeBoundary>" where typeName and typeBoundary must be known types
    // - must be terminated by >
    // - lack of any other tokens than <, ?, > and known object names
    // - all symbols involved are known object types
    var boundaries = new List<Expr>();

    if(!parser.lookAheadFor(SolvrTokens.NAME)) {
      throw new ParserError('generic expression name error for token ${parser.current()}');
    }
    var boundary = _makeSymbol(parser.consume());
    if(!parser.isObjectType(boundary)) {
      throw new ParserError('unknown generic boundary object $boundary');
    }

    if(parser.consumeMatch(SolvrTokens.LESS_THAN)) {
      boundaries.add(_parseGeneric(parser, boundary));
    } else {
      boundaries.add(boundary);
    }
    parser.consumeExpected(SolvrTokens.GREATER_THAN);

    if(boundaries.isEmpty) {
      throw new ParserError('generic expressions must have boundaries ${parser.current()}');
    }

    return Expr.genericExpr(template, boundaries, span.end());
  }

  SymbolExpr _makeSymbol(Token token) => Expr.symbolExpr(token.value, token.location);
  
  static final _logger = LoggerFactory.getLoggerFor(NameParselet);
}
