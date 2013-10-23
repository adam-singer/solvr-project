// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** [Parser] for the Solvr language */
class InputParser extends Parser {
  // TODO rename to SolvrParser
  
  InputParser(String sourceString)
    : super(new Lexer(new StringReader(sourceString)), new InputGrammar());

  /** Parse entire module */
  List<Expr> parseModule() {
    List<Expr> exprs = [];

    while (!lookAheadFor(TokenType.EOF)) {
      Expr expr = parse();
      exprs.add(expr);
      if (!lookAheadFor(TokenType.EOF)) {
        consumeExpected(TokenType.LINE);
      }
    }
    return exprs;
  }

  /**
  * Parse a single statement and expression. Generally everything that cannot directly take part
  * of or impacts automatic simplification, such as if-else statements, are considered a
  * statement.
  */
  Expr parse() {
    if (lookAheadFor(TokenType.IF)) return parseIf();
    if (lookAheadFor(TokenType.RETURN)) return parseReturn();

    Expr expr = parseExpression();

    // check all tokens are consumed (subtract one as EOF token is never consumed)
    var expected = _returnedTokens - 1;
    if(_consumedTokens.length != expected) throw new ParserError("only consumed ${_consumedTokens.length} of ${expected} tokens");

    // fix erronous precedence structure caused by injected expressions
    if(!_tainted.isEmpty) {
      var parser = new InputParser(expr.root.toString());
      return parser.parse();
    }
    return expr;
  }

  /**
   * Parse expression. In Solvr anything that can take part of
   * automatic simplification are considered an expression
   */
  Expr parseExpression([int precedence=0]) {
    // parse prefix
    var token = consume();
    var prefixParselet = grammar.getPrefixParselet(token.type);
    if(prefixParselet == null) throw new ParserError("Could not find prefix parser for token [${token}]");
    Expr left = prefixParselet.parse(this, token);

    // parse infix
    while ( precedence < grammar.getPrecedence(current()) ) {
      token = consume();

      InfixParselet infixParselet = grammar.getInfixParselet(token.type);
      if(infixParselet == null) throw new ParserError("Could not find infix parser for ${token.value}");

      left = infixParselet.parse(this, left, token);
    }
    return left;
  }

  /** Handle missing "multipication" in expressions such as 2(x+3), 3!(3+2), (2+3)(3+4). */
  Expr checkForProduct(Expr expr) {
    if(immediateMatch(TokenType.LEFT_PAREN) || immediateMatch(TokenType.NAME)) {
      _logger.debug("product balancing $expr");
      var taintedExpr = Expr.productExpr(null, expr, parseExpression());
      _tainted.add(taintedExpr);
      return taintedExpr;
    }
    return expr;
  }

  /** Handle missing logical "and" in expressions such as x > 5 > y (parse as: x > 5 && 5 > y) */
  Expr checkForAnd(RelationalExpr expr) {
    if(isRelational(expr.left)) {
      _logger.debug("and balancing $expr");
      var clone = expr.clone as RelationalExpr;
      clone.left = (expr.left as RelationalExpr).right;
      var taintedExpr = Expr.andExpr(null, expr.left, clone);
      _tainted.add(taintedExpr);
      return taintedExpr;
    } 
    return expr;
  }

  /**
   * Parse (a+b) and (x,y,...) like expressions.
   *
   * Expects that the starting left ( has already been consumed
   */
  TupleExpr parseTuple() {
    var position = span();
    var elements = new List();

    if (!lookAheadFor(TokenType.RIGHT_PAREN)) {
      do {
        elements.add(parseExpression());
      } while (consumeMatch(TokenType.COMMA));
    }
    consumeExpected(TokenType.RIGHT_PAREN);

    return Expr.tupleExpr(position.end(), elements);
  }

  /** Parse conditional expressions */
  Expr parseIf() {
    consumeAllExpected([TokenType.IF, TokenType.LEFT_PAREN]);
    Expr ifCondition = parseTuple();
    Expr ifBody = parseBlock();

    var position = span();
    Expr elseExpr = Expr.nothingExpr(last().position);
    if(consumeMatch(TokenType.ELSE)) {
      if(lookAheadFor(TokenType.IF)) {
        elseExpr = parseIf();
      } else {
        elseExpr = parseBlock();
      }
    }
    return Expr.conditionalExpr(position.end(), ifCondition, ifBody, elseExpr);
  }

  /** Parse block */
  Expr parseBlock() {
    var position = span();
    List<Expr> exprs = [];

    consumeExpected(TokenType.LEFT_BRACE);
    do {
      exprs.add(parse());
      if(consumeMatch(TokenType.RIGHT_BRACE)) {
        break;
      }
    } while(true);
    return Expr.blockExpr(position.end(), exprs);
  }

  /** Parse return statements */
  Expr parseReturn() {
    var position = span();
    consumeExpected(TokenType.RETURN);

    Expr value;
    if (lookAheadAny([TokenType.LINE, TokenType.RIGHT_BRACE])) {
      // A return with nothing after it
      value = Expr.nothingExpr(last().position);
    } else {
      value = parseExpression();
    }
    return Expr.returnExpr(position.end(), value);
  }

  bool isObjectType(SymbolExpr symbol) => _objectTypes.contains(symbol.value);

  registerObjectType(String typename) => _objectTypes.add(typename);

  registerObjectTypes(List<String> typenames) => _objectTypes.addAll(typenames);

  final _objectTypes = new Set<String>();
  final _tainted = new List<Expr>();
  static final _logger = LoggerFactory.getLoggerFor(InputParser);
}
