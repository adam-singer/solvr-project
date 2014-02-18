// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser_api;

class StringReader implements SourceReader {
  factory StringReader(String sourceString) {
    notNullOrEmpty(sourceString);
    return new StringReader._internal(sourceString, sourceString.length);
  }

  StringReader._internal(this._sourceString, this._sourceLength) {
    _position = 0;
  }

  String peek(int distance) {
    final int ahead = _position+distance;
    if (ahead >= _sourceLength) {
      return "";
    }
    return _sourceString.substring(ahead, ahead+_offset);
  }

  advance() {
    _position += _offset;
  }

  String toString() => _sourceString;

  final int _offset = 1;
  final String _sourceString;
  final int _sourceLength;
  int _position;
}
