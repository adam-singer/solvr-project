// Copyright (c) 2013 Solvr. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

/** Parser, lexer and grammar */
library solvr_kernel_parser;

import 'dart:collection';

import 'package:solvr_common/solvr_common.dart';

import 'ast_lib.dart';
import 'matcher_lib.dart';

part 'parser/infix/assign_parselet.dart';
part 'parser/infix/binary_parselet.dart';
part 'parser/infix/postfix_unary_parselet.dart';

part 'parser/prefix/brace_parselet.dart';
part 'parser/prefix/bracket_parselet.dart';
part 'parser/prefix/name_parselet.dart';
part 'parser/prefix/nullary_parselet.dart';
part 'parser/prefix/tuple_parselet.dart';
part 'parser/prefix/prefix_unary_parselet.dart';

part 'parser/grammar.dart';
part 'parser/infix_parselet.dart';
part 'parser/input_grammar.dart';
part 'parser/input_parser.dart';
part 'parser/lexer.dart';
part 'parser/parser.dart';
part 'parser/position_span.dart';
part 'parser/precedence.dart';
part 'parser/prefix_parselet.dart';
part 'parser/source_reader.dart';
part 'parser/string_reader.dart';
part 'parser/token.dart';
part 'parser/token_reader.dart';
part 'parser/token_type.dart';

class ParserError extends SolvrError {
  ParserError(this.errorMessage);
  final String errorMessage;
}