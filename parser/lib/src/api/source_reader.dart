// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser;

/** Abstract away source reading so [Lexer] stays the same when reading from files or REPL */
abstract class SourceReader {
  advance();

  String peek(int distance);
}
