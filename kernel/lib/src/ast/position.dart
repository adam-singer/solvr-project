// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Describes the location of a piece of text in a source file. */
class Position {
  Position(this.startCol, this.startLine, this.endCol, this.endLine);

  Position union(Position other) {
    int minStartCol = Math.min(startCol, other.startCol);
    int maxEndCol = Math.max(endCol, other.endCol);
    int minStartLine = Math.min(startLine, other.startLine);
    int maxEndLine = Math.max(endLine, other.endLine);

    return new Position(minStartCol, maxEndCol, minStartLine, maxEndLine);
  }

  toString() {
    if(startLine == endLine) {
      return "col $startCol to $endCol";
    }
    return "[line:$startLine col:$startCol to line:$endLine col:$endCol]";
  }

  final int startCol, endCol, startLine, endLine;
}
