// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_parser_test;

class LexerTest {
  LexerTest() {
    group("lexer", () {
      test("token matching", () {
        assertToken("   ", [TokenType.EOF]);
        assertToken(r"\", [TokenType.BACK_SLASH]);
        assertToken("1", [TokenType.NUMBER]);
        assertToken("x", [TokenType.NAME]);
        assertToken("x2", [TokenType.NAME]);
        assertToken("x_2", [TokenType.NAME]);
        assertToken("true", [TokenType.BOOL]);
        assertToken("42", [TokenType.NUMBER]);
        assertToken("1.1", [TokenType.NUMBER]);
        assertToken(r'""', [TokenType.STRING]);
        assertToken(r'"word"', [TokenType.STRING]);
        assertToken(r'"more words"', [TokenType.STRING]);
        assertToken("|", [TokenType.PIPE]);
        assertToken("||", [TokenType.LOGICAL_OR]);
        assertToken(":=", [TokenType.SUBSTITUTION]);
        assertToken("&&", [TokenType.LOGICAL_AND]);
        assertToken("in", [TokenType.IN]);
        assertToken("!subset", [TokenType.NOT_SUBSET]);
        assertToken("is", [TokenType.INSTANCE_OF]);
        assertToken("is!", [TokenType.NOT_INSTANCE_OF]);
        assertToken("intersect", [TokenType.INTERSECT]);
        assertToken("union", [TokenType.UNION]);
        assertToken(".1", [TokenType.DOT, TokenType.NUMBER]);
        assertToken("-42", [TokenType.MINUS, TokenType.NUMBER]);
        assertToken("2x", [TokenType.NUMBER, TokenType.NAME]);
        assertToken("x!", [TokenType.NAME, TokenType.BANG]);
        assertToken("1..10", [TokenType.NUMBER, TokenType.DOTS, TokenType.NUMBER]);
        assertToken("1 + 2", [TokenType.NUMBER, TokenType.PLUS, TokenType.NUMBER]);
        assertToken("2 * x", [TokenType.NUMBER, TokenType.ASTERISK, TokenType.NAME]);
        assertToken("x^2", [TokenType.NAME, TokenType.CARET, TokenType.NUMBER]);
        assertToken("8 == 7", [TokenType.NUMBER, TokenType.EQUAL, TokenType.NUMBER]);
        assertToken(" 1 + 2 * 3 ", [TokenType.NUMBER, TokenType.PLUS, TokenType.NUMBER, TokenType.ASTERISK, TokenType.NUMBER]);
        assertToken("gcd(3,9)", [TokenType.NAME, TokenType.LEFT_PAREN, TokenType.NUMBER, TokenType.COMMA, TokenType.NUMBER, TokenType.RIGHT_PAREN]);
        assertToken("2(-3)", [TokenType.NUMBER, TokenType.LEFT_PAREN, TokenType.MINUS, TokenType.NUMBER, TokenType.RIGHT_PAREN]);
        assertToken("(x) => x+1", [TokenType.LEFT_PAREN, TokenType.NAME, TokenType.RIGHT_PAREN, TokenType.LEFT_ARROW, TokenType.NAME, TokenType.PLUS, TokenType.NUMBER]);
        assertToken("3!(-3 + 5)", [TokenType.NUMBER, TokenType.BANG, TokenType.LEFT_PAREN, TokenType.MINUS, TokenType.NUMBER, TokenType.PLUS, TokenType.NUMBER, TokenType.RIGHT_PAREN]);
        assertToken(r'''
          if(true) {
            print("hello")
          }
        ''', [TokenType.IF, TokenType.LEFT_PAREN, TokenType.BOOL, TokenType.RIGHT_PAREN, TokenType.LEFT_BRACE, 
              TokenType.NAME, TokenType.LEFT_PAREN, TokenType.STRING, TokenType.RIGHT_PAREN, TokenType.RIGHT_BRACE]);
      }); 
      // TODO test position when used with whitespace and new lines (multiline strings)
    });
  }
  
  assertToken(String text, List<TokenType> expectedTokens) {
    SourceReader reader = new StringReader(text);
    TokenReader lexer = new Lexer(reader);
    expectedTokens.forEach((t) {
      Token token = lexer.readToken();
      expect(token.type == t, isTrue, reason:"expected [${t}] got [${token.type.name}] at position ${token.position.toString()} for [$text]");
    });
    Token last = lexer.readToken();
    expect(last.type, equals(TokenType.EOF), reason:"expected EOF got [$last] for $text");
  }
}
