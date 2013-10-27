// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** Creates a position that spans a range of Tokens. */
class PositionSpan {
  PositionSpan(this._parser, this._start);

  Position end() {
    return _start.union(_parser.last().position);
  }
  
  final Parser _parser;
  final Position _start;
}
