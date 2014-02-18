// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** [Parser] for the Solvr language */
class SolvrParser extends Parser<Expr, SolvrParser> {
  SolvrParser(String sourceString)
    : super(new SolvrLexer(new StringReader(sourceString)), new SolvrGrammar());

  @override 
  List<Expr> parseModule() {
    List<Expr> exprs = [];

    while (!lookAheadFor(SolvrTokens.EOF)) {
      Expr expr = parse();
      exprs.add(expr);
      if (!lookAheadFor(SolvrTokens.EOF)) {
        consumeExpected(SolvrTokens.LINE);
      }
    }
    return exprs;
  }

  @override 
  Expr parse() {
    if (lookAheadFor(SolvrTokens.IF)) return parseIf();
    if (lookAheadFor(SolvrTokens.RETURN)) return parseReturn();

    Expr expr = parseExpression();

    // check all tokens are consumed (subtract one as EOF token is never consumed)
    var expected = returnedTokens - 1;
    if(consumedTokens != expected) throw new ParserError("only consumed ${consumedTokens} of ${expected} tokens");

    // fix erronous precedence structure caused by injected expressions
    if(!_tainted.isEmpty) {
      var parser = new SolvrParser(expr.root.toString());
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
    if(immediateMatch(SolvrTokens.LEFT_PAREN) || immediateMatch(SolvrTokens.NAME)) {
      _logger.debug("product balancing $expr");
      var taintedExpr = Expr.productExpr(expr, parseExpression());
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
      var taintedExpr = Expr.andExpr(expr.left, clone);
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
    var locationSpan = span();
    var elements = new List();

    if (!lookAheadFor(SolvrTokens.RIGHT_PAREN)) {
      do {
        elements.add(parseExpression());
      } while (consumeMatch(SolvrTokens.COMMA));
    }
    consumeExpected(SolvrTokens.RIGHT_PAREN);

    return Expr.tupleExpr(elements, locationSpan.end());
  }

  /** Parse conditional expressions */
  Expr parseIf() {
    consumeAllExpected([SolvrTokens.IF, SolvrTokens.LEFT_PAREN]);
    Expr ifCondition = parseTuple();
    Expr ifBody = parseBlock();

    var locationSpan = span();
    Expr elseExpr = Expr.nothingExpr(last().location);
    if(consumeMatch(SolvrTokens.ELSE)) {
      if(lookAheadFor(SolvrTokens.IF)) {
        elseExpr = parseIf();
      } else {
        elseExpr = parseBlock();
      }
    }
    return Expr.conditionalExpr(ifCondition, ifBody, elseExpr, locationSpan.end());
  }

  /** Parse block */
  Expr parseBlock() {
    var locationSpan = span();
    List<Expr> exprs = [];

    consumeExpected(SolvrTokens.LEFT_BRACE);
    do {
      exprs.add(parse());
      if(consumeMatch(SolvrTokens.RIGHT_BRACE)) {
        break;
      }
    } while(true);
    return Expr.blockExpr(exprs, locationSpan.end());
  }

  /** Parse return statements */
  Expr parseReturn() {
    var locationSpan = span();
    consumeExpected(SolvrTokens.RETURN);

    Expr value;
    if (lookAheadAny([SolvrTokens.LINE, SolvrTokens.RIGHT_BRACE])) {
      // A return with nothing after it
      value = Expr.nothingExpr(last().location);
    } else {
      value = parseExpression();
    }
    return Expr.returnExpr(value, locationSpan.end());
  }

  bool isObjectType(SymbolExpr symbol) => _objectTypes.contains(symbol.value);

  registerObjectType(String typename) => _objectTypes.add(typename);

  registerObjectTypes(List<String> typenames) => _objectTypes.addAll(typenames);

  final _objectTypes = new Set<String>();
  final _tainted = new List<Expr>();
  static final _logger = LoggerFactory.getLoggerFor(SolvrParser);
}
