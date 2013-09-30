// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

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

  String toString() {
    if(startLine == endLine) {
      return "col $startCol to $endCol";
    }
    return "[line:$startLine col:$startCol to line:$endLine col:$endCol]";
  }

  final int startCol, endCol, startLine, endLine;
}
