// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_parser;

class Token {
   Token(this.value, this.type, this.position, this.followedWhitespace);

   String toString() => "type: ${type} value: ${value}";

   final bool followedWhitespace;
   final Position position;
   final TokenType type;
   final String value;
}
