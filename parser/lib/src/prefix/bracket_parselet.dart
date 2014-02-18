// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** parses brackets in lists such as [1, 2] and vectors such as [1 2] and matrices as [[1 2];[3 4]] */
class BracketParselet implements PrefixParselet {
  Expr parse(SolvrParser parser, Token token) {
    _logger.debug("parsing: ${token.value}");

    var span = parser.span();
    var elements = new List<Expr>();
    var asList = true;
    var asMatrix = false;
    var asVector = false;

    if(!parser.lookAheadFor(SolvrTokens.RIGHT_BRACKET)) {
      // since the list is not empty we cannot be sure its not a vector/matrix
      asList = false;
      do {
        Expr expr = parser.parseExpression();
        elements.add(expr);

        if(parser.lookAheadFor(SolvrTokens.RIGHT_BRACKET)) {
          if(elements.length == 1) {
            // single elements like [1], [[]] or [[1; 2]] are always treated as a list
            asList = true;
          }
          break;
        }

        if(parser.consumeMatch(SolvrTokens.COMMA)) {
          if(asMatrix || asVector) throw new ParserError('expected list type');
          asList = true;
        } else if(parser.consumeMatch(SolvrTokens.SEMI_COLON)) {
          if(asList) throw new ParserError('unexpected list type');
          if(!asVector && !asMatrix) {
            // determin type of expression
            if(isVector(expr)) {
              asMatrix = true;
            } else {
              asVector = true;
            }
          }
        }
      } while (true);
    }
    parser.consumeExpected(SolvrTokens.RIGHT_BRACKET);
    var location = span.end();

    if(asList) {
      return Expr.listExpr(elements, location);
    } else if(asMatrix) {
      var vectors = new List<VectorExpr>();
      elements.forEach((var e) => vectors.add(e));
      return Expr.matrixExpr(vectors, location);
    } else if(asVector) {
      return Expr.vectorExpr(elements, location);
    }
    throw new ParserError("bracket parser error for ${token.toString()}");
  }
  
  static final _logger = LoggerFactory.getLoggerFor(BracketParselet);
}
