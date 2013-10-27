// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** The [Token] types defined for the Solvr language */
class TokenType {
  const TokenType(this.name);

  // grouping
  static const COMMA = const TokenType("comma");
  static const COLON = const TokenType("colon");
  static const DOT = const TokenType("dot");
  static const DOTS = const TokenType("dots");
  static const ENTRY = const TokenType("entry");
  static const LEFT_BRACE = const TokenType("left brace");
  static const LEFT_BRACKET = const TokenType("left bracket");
  static const LEFT_PAREN = const TokenType("left paren");
  static const PIPE = const TokenType("pipe");
  static const REFERENCE = const TokenType("reference");
  static const RIGHT_BRACE = const TokenType("right brace");
  static const RIGHT_BRACKET = const TokenType("right bracket");
  static const RIGHT_PAREN = const TokenType("right paren");
  static const SEMI_COLON = const TokenType("semi colon");

  // math operators
  static const ASTERISK = const TokenType("asterisk");
  static const BANG = const TokenType("bang");
  static const CARET = const TokenType("caret");
  static const MINUS = const TokenType("minus");
  static const PLUS = const TokenType("plus");
  static const SLASH = const TokenType("slash");

  // logical operators
  static const LOGICAL_AND = const TokenType("and");
  static const LOGICAL_OR = const TokenType("or");

  // object operators
  static const CLASS = const TokenType("class");
  static const EXTENDS = const TokenType("extends");
  static const IN = const TokenType("in");
  static const INSTANCE_OF = const TokenType("instance of");
  static const IMPLEMENTS = const TokenType("implements");
  static const INTERFACE = const TokenType("interface");
  static const NEW = const TokenType("new");
  static const NOT_INSTANCE_OF = const TokenType("not instance of");

  // comparison operators
  static const EQUAL = const TokenType("equal");
  static const LESS_THAN = const TokenType("less than");
  static const LESS_THAN_OR_EQUAL = const TokenType("less than or equal");
  static const GREATER_THAN = const TokenType("greater than");
  static const GREATER_THAN_OR_EQUAL = const TokenType("greater than or equal");
  static const NOT_EQUAL = const TokenType("not equal");

  // set operators
  static const BACK_SLASH = const TokenType("complement");
  static const INTERSECT = const TokenType("intersect");
  static const NOT_SUBSET = const TokenType("not subset");
  static const SUBSET = const TokenType("subset");
  static const UNION = const TokenType("union");

  // tokens that require special parsing
  static const ASSIGN = const TokenType("assign");
  static const BOOL = const TokenType("bool");
  static const ELSE = const TokenType("else");
  static const EOF = const TokenType("eof");
  static const IF = const TokenType("if");
  static const LEFT_ARROW = const TokenType("left arrow");
  static const LINE = const TokenType("line");
  static const NAME = const TokenType("name");
  static const NUMBER = const TokenType("number");
  static const RETURN = const TokenType("return");
  static const STRING = const TokenType("string");
  static const SUBSTITUTION = const TokenType("substitution");

  String toString() => name;

  final String name;
}
