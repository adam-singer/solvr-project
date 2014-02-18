// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** [Grammar] for the Solvr language  */
class SolvrGrammar implements Grammar<Expr, SolvrParser> {
  SolvrGrammar() {
    _registerPrefixExpressionsWithSpecialParselets();
    _registerInfixExpressionsWithSpecialParselets();
    _registerUnaryPrefixExpressions();
    _registerUnaryPostfixExpressions();
    _registerInfixLeftAssociativeExpressions();
    _registerInfixRightAssociativeExpressions();
  }
  
  _registerPrefixExpressionsWithSpecialParselets() {
    _addPostfixExpressionParselet(SolvrTokens.BOOL, new NullaryParselet());
    _addPostfixExpressionParselet(SolvrTokens.LEFT_PAREN, new TupleParselet());
    _addPostfixExpressionParselet(SolvrTokens.LEFT_BRACE, new BraceParselet());
    _addPostfixExpressionParselet(SolvrTokens.LEFT_BRACKET, new BracketParselet());
    _addPostfixExpressionParselet(SolvrTokens.NAME, new NameParselet());
    _addPostfixExpressionParselet(SolvrTokens.NUMBER, new NullaryParselet());
    _addPostfixExpressionParselet(SolvrTokens.RIGHT_BRACKET, new BracketParselet());
    _addPostfixExpressionParselet(SolvrTokens.STRING, new NullaryParselet());
  } 
  
  _registerInfixExpressionsWithSpecialParselets() {
    _addInfixExpressionParselet(SolvrTokens.ASSIGN, new AssignParselet());
    _addInfixExpressionParselet(SolvrTokens.SUBSTITUTION, new AssignParselet());
    _addInfixExpressionParselet(SolvrTokens.LEFT_ARROW, new AssignParselet());
  }
  
  _registerUnaryPrefixExpressions() {
    _addUnaryPrefixExpression(SolvrTokens.MINUS, Precedence.PREFIX);
    _addUnaryPrefixExpression(SolvrTokens.BANG, Precedence.LOGICAL_NOT);
    // handle numbers with no leading zero fx .1, 0.11 etc.
    _addUnaryPrefixExpression(SolvrTokens.DOT, Precedence.LITERAL);
  }
  
  _registerUnaryPostfixExpressions() {
    // "!" is both prefix, infix and postfix (i.e. negation and faculty function)
    _addUnaryPostfixExpression(SolvrTokens.BANG, Precedence.POSTFIX);
  }
  
  _registerInfixLeftAssociativeExpressions() {
    _addInfixLeftAssociativeExpression(SolvrTokens.ASTERISK, Precedence.PRODUCT);
    _addInfixLeftAssociativeExpression(SolvrTokens.BACK_SLASH, Precedence.SUM);
    _addInfixLeftAssociativeExpression(SolvrTokens.COLON, Precedence.ASSIGNMENT);
    _addInfixLeftAssociativeExpression(SolvrTokens.DOT, Precedence.PRODUCT);
    _addInfixLeftAssociativeExpression(SolvrTokens.DOTS, Precedence.INTERVAL);
    _addInfixLeftAssociativeExpression(SolvrTokens.EQUAL, Precedence.EQUALITY);
    _addInfixLeftAssociativeExpression(SolvrTokens.GREATER_THAN, Precedence.COMPARISON);
    _addInfixLeftAssociativeExpression(SolvrTokens.GREATER_THAN_OR_EQUAL, Precedence.COMPARISON);
    _addInfixLeftAssociativeExpression(SolvrTokens.INTERSECT, Precedence.PRODUCT);
    _addInfixLeftAssociativeExpression(SolvrTokens.INSTANCE_OF, Precedence.EQUALITY);
    _addInfixLeftAssociativeExpression(SolvrTokens.NOT_INSTANCE_OF, Precedence.EQUALITY);
    _addInfixLeftAssociativeExpression(SolvrTokens.IN, Precedence.ASSIGNMENT);
    _addInfixLeftAssociativeExpression(SolvrTokens.INTERSECT, Precedence.PRODUCT);
    _addInfixLeftAssociativeExpression(SolvrTokens.LESS_THAN, Precedence.COMPARISON);
    _addInfixLeftAssociativeExpression(SolvrTokens.LESS_THAN_OR_EQUAL, Precedence.COMPARISON);
    _addInfixLeftAssociativeExpression(SolvrTokens.MINUS, Precedence.SUM);
    _addInfixLeftAssociativeExpression(SolvrTokens.NOT_EQUAL, Precedence.EQUALITY);
    _addInfixLeftAssociativeExpression(SolvrTokens.NOT_SUBSET, Precedence.COMPARISON);
    _addInfixLeftAssociativeExpression(SolvrTokens.PIPE, Precedence.ASSIGNMENT);
    _addInfixLeftAssociativeExpression(SolvrTokens.PLUS, Precedence.SUM);
    _addInfixLeftAssociativeExpression(SolvrTokens.SLASH, Precedence.PRODUCT);
    _addInfixLeftAssociativeExpression(SolvrTokens.SUBSET, Precedence.COMPARISON);
    _addInfixLeftAssociativeExpression(SolvrTokens.UNION, Precedence.SUM);
    _addInfixLeftAssociativeExpression(SolvrTokens.ASTERISK, Precedence.PRODUCT);
  }
  
  _registerInfixRightAssociativeExpressions() {
    // infix right operators
    _addInfixRightAssociativeExpression(SolvrTokens.CARET, Precedence.EXPONENT);
    _addInfixRightAssociativeExpression(SolvrTokens.LOGICAL_AND, Precedence.LOGICAL_AND);
    _addInfixRightAssociativeExpression(SolvrTokens.LOGICAL_OR, Precedence.LOGICAL_OR);
  }
  
  _addPostfixExpressionParselet(TokenType token, PrefixParselet parselet) {
    _prefixParselets[token] = parselet;
  }
  
  _addInfixExpressionParselet(TokenType token, InfixParselet parselet) {
    _infixParselets[token] = parselet;
  }
  
  _addUnaryPrefixExpression(TokenType token, int precedence) {
   _addPostfixExpressionParselet(token,  new PrefixUnaryParselet(precedence));
  }

  _addUnaryPostfixExpression(TokenType token, int precedence) {
    _infixParselets[token] = new PostfixUnaryParselet(precedence);
  }

  _addInfixLeftAssociativeExpression(TokenType token, int precedence) {
    _addInfixExpressionParselet(token, new BinaryParselet(precedence, false));
  }

  _addInfixRightAssociativeExpression(TokenType token, int precedence) {
    _addInfixExpressionParselet(token, new BinaryParselet(precedence, true));
  }

  @override
  PrefixParselet getPrefixParselet(TokenType type) => _prefixParselets[type];

  @override
  InfixParselet getInfixParselet(TokenType type) => _infixParselets[type];

  @override
  int getPrecedence(Token token) {
    InfixParselet parselet = getInfixParselet(token.type);
    if (parselet != null) {
      return parselet.precedence;
    }
    return 0;
  }

  final Map<TokenType, InfixParselet> _infixParselets = new Map<TokenType, InfixParselet>();
  final Map<TokenType, PrefixParselet> _prefixParselets = new Map<TokenType, PrefixParselet>();
}
