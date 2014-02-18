// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser_api;

/** Creates a location that spans a range of Tokens. */
class LocationSpan {
  LocationSpan(this._parser, this._start);

  Location end() {
    return _start.union(_parser.last().location);
  }
  
  final Parser _parser;
  final Location _start;
}
