// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** [Lexer] for the Solvr language */
class SolvrLexer implements Lexer {
  SolvrLexer(this._text) {
    if(_followSet == null) {
      _buildFollow();
    }
    _line = 1;
    _col = 1;
    _markStartingPoint();
  }

  Token readToken() {
    var c = _advanceAndConsumeWhitespace();

    if(c == "") {
      // add EOF token, so the parser doesn't have to worry about running out of tokens.
      return _makeToken(SolvrTokens.EOF);
    } else if (_isName(c)) {
      return _readName();
    } else if (_isPunctuator(c)) {
      return _readPunctuator();
    } else if (_isNumber(c)) {
      return _readNumber();
    } else if(c == '"') {
      return _readString();
    } else {
      throw _error();
    }
  }

  bool _isWhiteSpace(s) => _whitespaceRegex.hasMatch(s);

  bool _isNumber(s) => _numberRegex.hasMatch(s);

  bool _isPunctuator(s) => r"[!^&*-=+|/\<>(){},.;:]".indexOf(s) != -1;

  bool _isName(s) => _nameRegex.hasMatch(s);

  Token _readName() {
    while(true) {
      String c = _peek();
      // since we only enter the read name function when we already have matched a [a-z] we do not
      // need to check if the first letter is a number, just check the following are alphanumeric
      if(!_isName(c) && !_isNumber(c) && c != "_") {
        break;
      }
      _advance();
    }

    if(_reservedWords.containsKey(_read)) {
      return _makeReservedToken();
    }
    return _makeToken(SolvrTokens.NAME);
  }

  Token _readNumber() {
    bool decimal = false;
    while(true) {
      if(!decimal && _peek() == "." && _isNumber(_peek(1))) {
        decimal = true;
      } else if(!_isNumber(_peek())) {
        break;
      }
      _advance();
    }
    return _makeToken(SolvrTokens.NUMBER);
  }

  Token _readPunctuator() {
    if(!_reservedWords.containsKey(_read)) {
      throw _error();
    }
    return _makeReservedToken();
  }

  Token _readString() {
    var escaped = new StringBuffer();

    while (true) {
      var c = _advance();
      switch (c) {
      case r"\\":
        var e = _advance();
        switch (e) {
        case r"b": escaped.write("\b"); break;
        case r"f": escaped.write("\f"); break;
        case r"n": escaped.write("\n"); break;
        case r"r": escaped.write("\r"); break;
        case r"t": escaped.write("\t"); break;
        case r'"': escaped.write("\""); break;
        case r"\\": escaped.write("\\"); break;
        case "0": escaped.write("\0"); break;
        // TODO hex/utf didgits

        default:
          throw new ParserError("Unknown string escape $e");
        }
        break;

      case '"':
        return _makeTokenOf(SolvrTokens.STRING, escaped.toString());

      case '\0': throw new ParserError("Unterminated string.");

      default:
        escaped.write(c);
      }
    }
  }

  _makeReservedToken() {
    TokenType tokenType = _reservedWords[_read];
    _followSet[_read].forEach((String follow) {
      if(_advanceIfMatch(follow)) {
        tokenType = _reservedWords[_read];
        return;
      }
    });
    return _makeToken(tokenType);
  }

  Token _makeToken(TokenType type) => _makeTokenOf(type, _read);

  Token _makeTokenOf(TokenType type, String content) {
    Token token = new Token(content, type, _currentLocation, _isWhiteSpace(_last));
    _markStartingPoint();
    _logger.debug("read token ${token.toString()}");
    return token;
  }

  Location get _currentLocation {
    return new Location(_startCol, _startLine, _col, _line);
  }

  _markStartingPoint() {
    // starting position of the next token
    _startLine = _line;
    _startCol = _col;
    // ready stream for new token
    _cur = "";
    _last = "";
    _read = "";
  }

  String _advance() => _advanceToken(false);

  String _advanceAndConsumeWhitespace() => _advanceToken(true);

  String _advanceToken(bool consumeWhitespace) {
    _last = _cur;
    _cur = _peek();
    _text.advance();

    // update position.
    if (_cur == r"\n") {
      _line++;
      _col = 1;
    } else {
      _col++;
    }
    _logger.debug("read ${_cur} in $_text");

    if(_isWhiteSpace(_cur) && consumeWhitespace) {
      return _advanceToken(consumeWhitespace);
    } else {
      _read+= _cur;
      return _cur;
    }
  }

  bool _advanceIfMatch(String expected) {
    String match = "";
    int i = 0;
    while(i < expected.length) {
      match += _peek(i);
      i++;
    }
    if(match != expected) {
      return false;
    }
    // we had a match, consume the tokens
    while(i > 0) {
      _advance();
      i--;
    }
    return true;
  }

  String _peek([int distance = 0]) {
    return _text.peek(distance);
  }

  Error _error() => new ParserError("illegal token: ${_read} at ${_currentLocation} in source [${_text}]");

  // token follow set (i.e. possible tokens that can follow other tokens)
  static Map<String, List<String>> _followSet;
  static _buildFollow() {
    _followSet = new LinkedHashMap<String, List<String>>();
    _reservedWords.keys.forEach((String token) {
      List<String> follow = [];
      _reservedWords.keys.forEach((String word) {
        if(word.length > token.length && word.substring(0, token.length) == token) {
          follow.add(word.substring(token.length, word.length));
        }
      });
      // sort by longest possible match
      follow.sort((String a, String b) => a == b ? 0 : a.length > b.length ? -1 : 1);
      _followSet[token] = follow;
    });
    //_followSet.forEach((t, l) => print("token $t has follow $l"));
  }

  static Map<String, TokenType> _reservedWords =
    const {
     // grouping
     ":": SolvrTokens.COLON,
     ",": SolvrTokens.COMMA,
     ".": SolvrTokens.DOT,
     "..": SolvrTokens.DOTS,
     "{": SolvrTokens.LEFT_BRACE,
     "[": SolvrTokens.LEFT_BRACKET,
     "(": SolvrTokens.LEFT_PAREN,
     "|": SolvrTokens.PIPE,
     "&": SolvrTokens.REFERENCE,
     "}": SolvrTokens.RIGHT_BRACE,
     "]": SolvrTokens.RIGHT_BRACKET,
     ")": SolvrTokens.RIGHT_PAREN,
     ";": SolvrTokens.SEMI_COLON,

     // math operators
     "*": SolvrTokens.ASTERISK,
     "!": SolvrTokens.BANG,
     "^": SolvrTokens.CARET,
     "-": SolvrTokens.MINUS,
     "+": SolvrTokens.PLUS,
     "/": SolvrTokens.SLASH,

     // logical operators
     "&&": SolvrTokens.LOGICAL_AND,
     "||": SolvrTokens.LOGICAL_OR,

     // object operators
     "class": SolvrTokens.CLASS,
     "extends": SolvrTokens.EXTENDS,
     "in": SolvrTokens.IN,
     "is": SolvrTokens.INSTANCE_OF,
     "implements": SolvrTokens.IMPLEMENTS,
     "interface": SolvrTokens.INTERFACE,
     "new": SolvrTokens.NEW,
     "is!": SolvrTokens.NOT_INSTANCE_OF,

     // comparison operators
     "==": SolvrTokens.EQUAL,
     "<": SolvrTokens.LESS_THAN,
     "<=": SolvrTokens.LESS_THAN_OR_EQUAL,
     ">": SolvrTokens.GREATER_THAN,
     ">=": SolvrTokens.GREATER_THAN_OR_EQUAL,
     "!=": SolvrTokens.NOT_EQUAL,

     // set operators
     r"\": SolvrTokens.BACK_SLASH,
     "intersect": SolvrTokens.INTERSECT,
     "!subset": SolvrTokens.NOT_SUBSET,
     "subset": SolvrTokens.SUBSET,
     "union": SolvrTokens.UNION,

     // tokens that requres special parsing
     "=": SolvrTokens.ASSIGN,
     "false": SolvrTokens.BOOL,
     "true": SolvrTokens.BOOL,
     "else": SolvrTokens.ELSE,
     "if": SolvrTokens.IF,
     "=>": SolvrTokens.LEFT_ARROW,
     "return": SolvrTokens.RETURN,
     ":=": SolvrTokens.SUBSTITUTION
  };

  var _numberRegex = new RegExp(r"^(\d+)");
  var _nameRegex = new RegExp(r"^([a-zA-Z]+)");
  var _whitespaceRegex = new RegExp(r"(\s+)");

  int _startLine, _line, _startCol, _col;
  SourceReader _text;
  String _cur, _last, _read;
  static final _logger = LoggerFactory.getLoggerFor(SolvrLexer);
}




