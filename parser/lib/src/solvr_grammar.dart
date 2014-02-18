// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** [Grammar] for the Solvr language  */
class SolvrGrammar implements Grammar {
  SolvrGrammar()
    : _infixParselets = new Map<TokenType, InfixParselet>(),
      _prefixParselets = new Map<TokenType, PrefixParselet>()
    {
    // prefix tokens that need special parselets.
    _prefixParselet(SolvrTokens.BOOL, new NullaryParselet());
    _prefixParselet(SolvrTokens.LEFT_PAREN, new TupleParselet());
    _prefixParselet(SolvrTokens.LEFT_BRACE, new BraceParselet());
    _prefixParselet(SolvrTokens.LEFT_BRACKET, new BracketParselet());
    _prefixParselet(SolvrTokens.NAME, new NameParselet());
    _prefixParselet(SolvrTokens.NUMBER, new NullaryParselet());
    _prefixParselet(SolvrTokens.RIGHT_BRACKET, new BracketParselet());
    _prefixParselet(SolvrTokens.STRING, new NullaryParselet());

    // infix tokens that need special parselets.
    _infixParselet(SolvrTokens.ASSIGN, new AssignParselet());
    _infixParselet(SolvrTokens.SUBSTITUTION, new AssignParselet());
    _infixParselet(SolvrTokens.LEFT_ARROW, new AssignParselet());

    // unary operators
    _prefixOperator(SolvrTokens.MINUS, Precedence.PREFIX);
    _prefixOperator(SolvrTokens.BANG, Precedence.LOGICAL_NOT);
    // handle numbers with no leading zero fx .1, 0.11 etc.
    _prefixOperator(SolvrTokens.DOT, Precedence.LITERAL);

    // "!" is both prefix, infix and postfix (i.e. negation and faculty function)
    _postfixOperator(SolvrTokens.BANG, Precedence.POSTFIX);

    // infix left operators
    _infixOperatorLeft(SolvrTokens.ASTERISK, Precedence.PRODUCT);
    _infixOperatorLeft(SolvrTokens.BACK_SLASH, Precedence.SUM);
    _infixOperatorLeft(SolvrTokens.COLON, Precedence.ASSIGNMENT);
    _infixOperatorLeft(SolvrTokens.DOT, Precedence.PRODUCT);
    _infixOperatorLeft(SolvrTokens.DOTS, Precedence.INTERVAL);
    _infixOperatorLeft(SolvrTokens.EQUAL, Precedence.EQUALITY);
    _infixOperatorLeft(SolvrTokens.GREATER_THAN, Precedence.COMPARISON);
    _infixOperatorLeft(SolvrTokens.GREATER_THAN_OR_EQUAL, Precedence.COMPARISON);
    _infixOperatorLeft(SolvrTokens.INTERSECT, Precedence.PRODUCT);
    _infixOperatorLeft(SolvrTokens.INSTANCE_OF, Precedence.EQUALITY);
    _infixOperatorLeft(SolvrTokens.NOT_INSTANCE_OF, Precedence.EQUALITY);
    _infixOperatorLeft(SolvrTokens.IN, Precedence.ASSIGNMENT);
    _infixOperatorLeft(SolvrTokens.INTERSECT, Precedence.PRODUCT);
    _infixOperatorLeft(SolvrTokens.LESS_THAN, Precedence.COMPARISON);
    _infixOperatorLeft(SolvrTokens.LESS_THAN_OR_EQUAL, Precedence.COMPARISON);
    _infixOperatorLeft(SolvrTokens.MINUS, Precedence.SUM);
    _infixOperatorLeft(SolvrTokens.NOT_EQUAL, Precedence.EQUALITY);
    _infixOperatorLeft(SolvrTokens.NOT_SUBSET, Precedence.COMPARISON);
    _infixOperatorLeft(SolvrTokens.PIPE, Precedence.ASSIGNMENT);
    _infixOperatorLeft(SolvrTokens.PLUS, Precedence.SUM);
    _infixOperatorLeft(SolvrTokens.SLASH, Precedence.PRODUCT);
    _infixOperatorLeft(SolvrTokens.SUBSET, Precedence.COMPARISON);
    _infixOperatorLeft(SolvrTokens.UNION, Precedence.SUM);
    _infixOperatorLeft(SolvrTokens.ASTERISK, Precedence.PRODUCT);

    // infix right operators
    _infixOperatorRight(SolvrTokens.CARET, Precedence.EXPONENT);
    _infixOperatorRight(SolvrTokens.LOGICAL_AND, Precedence.LOGICAL_AND);
    _infixOperatorRight(SolvrTokens.LOGICAL_OR, Precedence.LOGICAL_OR);
  }

   // registers a postfix unary operator parselet for the given token and precedence
   _postfixOperator(TokenType token, int precedence) {
     _infixParselets[token] = new PostfixUnaryParselet(precedence);
   }

   // registers a prefix unary operator parselet for the given token and precedence
   _prefixOperator(TokenType token, int precedence) {
     _prefixParselet(token,  new PrefixUnaryParselet(precedence));
   }

   // registers a prefix parselet
   _prefixParselet(TokenType token, PrefixParselet parselet) {
     _prefixParselets[token] = parselet;
   }

   // registers a infix parselet
   _infixParselet(TokenType token, InfixParselet parselet) {
     _infixParselets[token] = parselet;
   }

   // registers a left-associative binary operator parselet
   _infixOperatorLeft(TokenType token, int precedence) {
     _infixParselet(token, new BinaryParselet(precedence, false));
   }

   // registers a right-associative binary operator parselet
   _infixOperatorRight(TokenType token, int precedence) {
     _infixParselets[token] = new BinaryParselet(precedence, true);
   }

   PrefixParselet getPrefixParselet(TokenType type) => _prefixParselets[type];

   InfixParselet getInfixParselet(TokenType type) => _infixParselets[type];

   int getPrecedence(Token token) {
     InfixParselet parselet = getInfixParselet(token.type);
     if (parselet != null) {
       return parselet.precedence;
     }
     return 0;
   }

   final Map<TokenType, InfixParselet> _infixParselets;
   final Map<TokenType, PrefixParselet> _prefixParselets;
}
