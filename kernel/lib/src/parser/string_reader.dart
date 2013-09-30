// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

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
