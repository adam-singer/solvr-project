// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser_test;

class LexerTest {
  LexerTest() {
    group("lexer -", () {
      test("single token matching", () {
        assertToken("   ", [SolvrTokens.EOF]);
        assertToken(r"\", [SolvrTokens.BACK_SLASH]);
        assertToken("1", [SolvrTokens.NUMBER]);
        assertToken("x", [SolvrTokens.NAME]);
        assertToken("x2", [SolvrTokens.NAME]);
        assertToken("x_2", [SolvrTokens.NAME]);
        assertToken("true", [SolvrTokens.BOOL]);
        assertToken("42", [SolvrTokens.NUMBER]);
        assertToken("1.1", [SolvrTokens.NUMBER]);
        assertToken(r'""', [SolvrTokens.STRING]);
        assertToken(r'"word"', [SolvrTokens.STRING]);
        assertToken(r'"more words"', [SolvrTokens.STRING]);
        assertToken("|", [SolvrTokens.PIPE]);
        assertToken("||", [SolvrTokens.LOGICAL_OR]);
        assertToken(":=", [SolvrTokens.SUBSTITUTION]);
        assertToken("&&", [SolvrTokens.LOGICAL_AND]);
        assertToken("in", [SolvrTokens.IN]);
        assertToken("!subset", [SolvrTokens.NOT_SUBSET]);
        assertToken("is", [SolvrTokens.INSTANCE_OF]);
        assertToken("is!", [SolvrTokens.NOT_INSTANCE_OF]);
        assertToken("intersect", [SolvrTokens.INTERSECT]);
        assertToken("union", [SolvrTokens.UNION]);
      });
      
      test("multiple token matching", () {
        assertToken(".1", [SolvrTokens.DOT, SolvrTokens.NUMBER]);
        assertToken("-42", [SolvrTokens.MINUS, SolvrTokens.NUMBER]);
        assertToken("2x", [SolvrTokens.NUMBER, SolvrTokens.NAME]);
        assertToken("x!", [SolvrTokens.NAME, SolvrTokens.BANG]);
        assertToken("1..10", [SolvrTokens.NUMBER, SolvrTokens.DOTS, SolvrTokens.NUMBER]);
        assertToken("1 + 2", [SolvrTokens.NUMBER, SolvrTokens.PLUS, SolvrTokens.NUMBER]);
        assertToken("2 * x", [SolvrTokens.NUMBER, SolvrTokens.ASTERISK, SolvrTokens.NAME]);
        assertToken("x^2", [SolvrTokens.NAME, SolvrTokens.CARET, SolvrTokens.NUMBER]);
        assertToken("8 == 7", [SolvrTokens.NUMBER, SolvrTokens.EQUAL, SolvrTokens.NUMBER]);
        assertToken(" 1 + 2 * 3 ", [SolvrTokens.NUMBER, SolvrTokens.PLUS, SolvrTokens.NUMBER, SolvrTokens.ASTERISK, SolvrTokens.NUMBER]);
        assertToken("gcd(3,9)", [SolvrTokens.NAME, SolvrTokens.LEFT_PAREN, SolvrTokens.NUMBER, SolvrTokens.COMMA, SolvrTokens.NUMBER, SolvrTokens.RIGHT_PAREN]);
        assertToken("2(-3)", [SolvrTokens.NUMBER, SolvrTokens.LEFT_PAREN, SolvrTokens.MINUS, SolvrTokens.NUMBER, SolvrTokens.RIGHT_PAREN]);
        assertToken("(x) => x+1", [SolvrTokens.LEFT_PAREN, SolvrTokens.NAME, SolvrTokens.RIGHT_PAREN, SolvrTokens.LEFT_ARROW, SolvrTokens.NAME, SolvrTokens.PLUS, SolvrTokens.NUMBER]);
        assertToken("3!(-3 + 5)", [SolvrTokens.NUMBER, SolvrTokens.BANG, SolvrTokens.LEFT_PAREN, SolvrTokens.MINUS, SolvrTokens.NUMBER, SolvrTokens.PLUS, SolvrTokens.NUMBER, SolvrTokens.RIGHT_PAREN]);
        assertToken(r'''
          if(true) {
            print("hello")
          }
        ''', [SolvrTokens.IF, SolvrTokens.LEFT_PAREN, SolvrTokens.BOOL, SolvrTokens.RIGHT_PAREN, SolvrTokens.LEFT_BRACE, 
              SolvrTokens.NAME, SolvrTokens.LEFT_PAREN, SolvrTokens.STRING, SolvrTokens.RIGHT_PAREN, SolvrTokens.RIGHT_BRACE]);
      }); 
    });
  }
  
  assertToken(String text, List<TokenType> expectedTokens) {
    SourceReader reader = new StringReader(text);
    Lexer lexer = new SolvrLexer(reader);
    expectedTokens.forEach((t) {
      Token token = lexer.readToken();
      expect(token.type == t, isTrue, reason:"expected [${t}] got [${token.type.name}] at location ${token.location} for [$text]");
    });
    Token last = lexer.readToken();
    expect(last.type, equals(SolvrTokens.EOF), reason:"expected EOF got [$last] for $text");
  }
}
