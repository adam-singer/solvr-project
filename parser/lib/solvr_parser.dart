// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

/** Parser, lexer and grammar */
library solvr_parser;

import 'dart:collection';

import 'package:solvr_ast/solvr_ast.dart';
import 'package:solvr_common/solvr_common.dart';
import 'package:solvr_matchers/solvr_matchers.dart';

part 'src/infix/assign_parselet.dart';
part 'src/infix/binary_parselet.dart';
part 'src/infix/postfix_unary_parselet.dart';

part 'src/prefix/brace_parselet.dart';
part 'src/prefix/bracket_parselet.dart';
part 'src/prefix/name_parselet.dart';
part 'src/prefix/nullary_parselet.dart';
part 'src/prefix/tuple_parselet.dart';
part 'src/prefix/prefix_unary_parselet.dart';

part 'src/grammar.dart';
part 'src/infix_parselet.dart';
part 'src/input_grammar.dart';
part 'src/input_parser.dart';
part 'src/lexer.dart';
part 'src/parser.dart';
part 'src/position_span.dart';
part 'src/precedence.dart';
part 'src/prefix_parselet.dart';
part 'src/source_reader.dart';
part 'src/string_reader.dart';
part 'src/token.dart';
part 'src/token_reader.dart';
part 'src/token_type.dart';

class ParserError extends SolvrError {
  ParserError(this.errorMessage);
  final String errorMessage;
}