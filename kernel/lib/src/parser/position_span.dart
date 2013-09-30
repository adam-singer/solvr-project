// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/**
 * Creates a position that spans a range of Tokens.
 */
class PositionSpan {
  PositionSpan(this._parser, this._start);

  Position end() {
    return _start.union(_parser.last().position);
  }
  
  final Parser _parser;
  final Position _start;
}
