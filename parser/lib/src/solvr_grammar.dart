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
    _prefixParselet(TokenType.BOOL, new NullaryParselet());
    _prefixParselet(TokenType.LEFT_PAREN, new TupleParselet());
    _prefixParselet(TokenType.LEFT_BRACE, new BraceParselet());
    _prefixParselet(TokenType.LEFT_BRACKET, new BracketParselet());
    _prefixParselet(TokenType.NAME, new NameParselet());
    _prefixParselet(TokenType.NUMBER, new NullaryParselet());
    _prefixParselet(TokenType.RIGHT_BRACKET, new BracketParselet());
    _prefixParselet(TokenType.STRING, new NullaryParselet());

    // infix tokens that need special parselets.
    _infixParselet(TokenType.ASSIGN, new AssignParselet());
    _infixParselet(TokenType.SUBSTITUTION, new AssignParselet());
    _infixParselet(TokenType.LEFT_ARROW, new AssignParselet());

    // unary operators
    _prefixOperator(TokenType.MINUS, Precedence.PREFIX);
    _prefixOperator(TokenType.BANG, Precedence.LOGICAL_NOT);
    // handle numbers with no leading zero fx .1, 0.11 etc.
    _prefixOperator(TokenType.DOT, Precedence.LITERAL);

    // "!" is both prefix, infix and postfix (i.e. negation and faculty function)
    _postfixOperator(TokenType.BANG, Precedence.POSTFIX);

    // infix left operators
    _infixOperatorLeft(TokenType.ASTERISK, Precedence.PRODUCT);
    _infixOperatorLeft(TokenType.BACK_SLASH, Precedence.SUM);
    _infixOperatorLeft(TokenType.COLON, Precedence.ASSIGNMENT);
    _infixOperatorLeft(TokenType.DOT, Precedence.PRODUCT);
    _infixOperatorLeft(TokenType.DOTS, Precedence.INTERVAL);
    _infixOperatorLeft(TokenType.EQUAL, Precedence.EQUALITY);
    _infixOperatorLeft(TokenType.GREATER_THAN, Precedence.COMPARISON);
    _infixOperatorLeft(TokenType.GREATER_THAN_OR_EQUAL, Precedence.COMPARISON);
    _infixOperatorLeft(TokenType.INTERSECT, Precedence.PRODUCT);
    _infixOperatorLeft(TokenType.INSTANCE_OF, Precedence.EQUALITY);
    _infixOperatorLeft(TokenType.NOT_INSTANCE_OF, Precedence.EQUALITY);
    _infixOperatorLeft(TokenType.IN, Precedence.ASSIGNMENT);
    _infixOperatorLeft(TokenType.INTERSECT, Precedence.PRODUCT);
    _infixOperatorLeft(TokenType.LESS_THAN, Precedence.COMPARISON);
    _infixOperatorLeft(TokenType.LESS_THAN_OR_EQUAL, Precedence.COMPARISON);
    _infixOperatorLeft(TokenType.MINUS, Precedence.SUM);
    _infixOperatorLeft(TokenType.NOT_EQUAL, Precedence.EQUALITY);
    _infixOperatorLeft(TokenType.NOT_SUBSET, Precedence.COMPARISON);
    _infixOperatorLeft(TokenType.PIPE, Precedence.ASSIGNMENT);
    _infixOperatorLeft(TokenType.PLUS, Precedence.SUM);
    _infixOperatorLeft(TokenType.SLASH, Precedence.PRODUCT);
    _infixOperatorLeft(TokenType.SUBSET, Precedence.COMPARISON);
    _infixOperatorLeft(TokenType.UNION, Precedence.SUM);
    _infixOperatorLeft(TokenType.ASTERISK, Precedence.PRODUCT);

    // infix right operators
    _infixOperatorRight(TokenType.CARET, Precedence.EXPONENT);
    _infixOperatorRight(TokenType.LOGICAL_AND, Precedence.LOGICAL_AND);
    _infixOperatorRight(TokenType.LOGICAL_OR, Precedence.LOGICAL_OR);
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
