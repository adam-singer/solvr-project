// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser_api;

class Token {
   Token(this.value, this.type, this.location, this.followedWhitespace);

   String toString() => "type: ${type} value: ${value}";

   final bool followedWhitespace;
   final Location location;
   final TokenType type;
   final String value;
}
