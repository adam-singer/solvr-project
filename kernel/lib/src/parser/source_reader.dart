// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

/**
 * Abstract away source reading so lexer stays the same when reading from files or REPL
 */
abstract class SourceReader {
  advance();

  String peek(int distance);
}
