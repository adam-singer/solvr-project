// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser_api;

/**
 * Generic super class for arbitrary lookahead recusive decent parser.
 *
 * This class should have no reference to the expresssions handled by the parser
 */
abstract class Parser<E, P extends Parser<E,P>> {
  Parser(this.lexer, this.grammar) {
    _readTokens = new List<Token>();
    _consumedTokens = new List<Token>();
    _returnedTokens = 0;
  }
  
  /** Parse entire module */
  List<E> parseModule();

  /**
  * Parse a single statement and expression. Generally everything that cannot directly take part
  * of or impacts automatic simplification, such as if-else statements, are considered a
  * statement.
  */
  E parse();
  
  /** The number of tokens consumed */
  int get consumedTokens => _consumedTokens.length;
  
  /** The number of tokens returned */
  int get returnedTokens => _returnedTokens;

  /** Consumes next token if it matches the expected else error is thrown */
  Token consumeExpected(TokenType expected) {
    Token token = current();
    if(token.type != expected) throw new ParserError("Expected token [${expected.toString()}] but found [${token.value}]");

    _logger.debug("consumed expected: ${token}");
    return consume();
  }

  /** Consumes next tokens if they matches the list of expected tokens else error is thrown */
  consumeAllExpected(List<TokenType> expected) => expected.forEach(consumeExpected);

  /** Consumes and return true if the next token matches the expected, else false */
   bool consumeMatch(TokenType token) {
    if (!lookAheadFor(token)) return false;

    _logger.debug("consumed match: ${token}");
    consume();
    return true;
  }

  /** Consumes the current token and advances to the next one. */
  Token consume() {
    current();
    // add the read token to the consumed stack
    _consumedTokens.insert(0, _readTokens[0]);
    _readTokens.removeRange(0, 1);
    return last(1);
  }

  // look n number of tokens ahead and put them on the current token stack (for look ahead/behind)
  Token _lookAhead(distance) {
    while (distance >= _readTokens.length) {
      _readTokens.add(lexer.readToken());
      _returnedTokens += 1;
    }
    return _readTokens[distance];
  }

  /**
   * True if the next token matches the expected.
   *
   * Does not consume any tokens
   */
  bool lookAheadFor(TokenType type) {
    Token next = current();
    return (next.type == type);
  }

  /**
   * True if the next token matches any of the expected.
   *
   * Does not consume any tokens
   */
  bool lookAheadAny(List<TokenType> types) => types.any(lookAheadFor);

  /**
   * True if the next token matches the expected and no whitespace was consumed.
   *
   * Does not consume any tokens
   */
  bool immediateMatch(TokenType type) => ((!current().followedWhitespace) && lookAheadFor(type));

  /** Consumes and return true if the next immedate token matches the expected, else false */
  bool consumeImmediateMatch(TokenType token) {
    if (!immediateMatch(token)) return false;

    _logger.debug("consumed match: ${token}");
    consume();
    return true;
  }

  /**
   * Gets current token (the next token that will be consumed).
   *
   * Does not consume any tokens
   */
  Token current() => _lookAhead(0);

  /** Gets a previously consumed Token. */
  Token last([int offset = 1]) {
    if(offset < 1) throw new ArgumentError("offset for last must be positive");
    return _consumedTokens[(offset - 1)];
  }

  /** Creates a [LocationSpan] that starts before the last consumed Token. */
  LocationSpan<E,P> span() => new LocationSpan(this, last().location);
  
  static final _logger = LoggerFactory.getLoggerFor(Parser);
  List<Token> _readTokens, _consumedTokens;
  Lexer lexer;
  int _returnedTokens;
  Grammar<E,P> grammar;
}
