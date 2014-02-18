// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser_api;

/** A legal [Token] in the language */
class TokenType {
  const TokenType(this.name);

  String toString() => name;

  final String name;
}
