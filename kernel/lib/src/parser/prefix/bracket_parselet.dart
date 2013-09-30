// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/**
 * parses brackets in lists such as [1, 2] and vectors such as [1 2] and matrices as [[1 2];[3 4]]
 */
class BracketParselet implements PrefixParselet {
  Expr parse(InputParser parser, Token token) {
    _logger.debug("parsing: ${token.value}");

    var span = parser.span();
    var elements = new List<Expr>();
    var asList = true;
    var asMatrix = false;
    var asVector = false;

    if(!parser.lookAheadFor(TokenType.RIGHT_BRACKET)) {
      // since the list is not empty we cannot be sure its not a vector/matrix
      asList = false;
      do {
        Expr expr = parser.parseExpression();
        elements.add(expr);

        if(parser.lookAheadFor(TokenType.RIGHT_BRACKET)) {
          if(elements.length == 1) {
            // single elements like [1], [[]] or [[1; 2]] are always treated as a list
            asList = true;
          }
          break;
        }

        if(parser.consumeMatch(TokenType.COMMA)) {
          if(asMatrix || asVector) throw new ParserError('expected list type');
          asList = true;
        } else if(parser.consumeMatch(TokenType.SEMI_COLON)) {
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
    parser.consumeExpected(TokenType.RIGHT_BRACKET);
    var position = span.end();

    if(asList) {
      return Expr.listExpr(position, elements);
    } else if(asMatrix) {
      var vectors = new List<VectorExpr>();
      elements.forEach((var e) => vectors.add(e));
      return Expr.matrixExpr(position, vectors);
    } else if(asVector) {
      return Expr.vectorExpr(position, elements);
    }
    throw new ParserError("bracket parser error for ${token.toString()}");
  }
  
  static final _logger = LoggerFactory.getLoggerFor(BracketParselet);
}
