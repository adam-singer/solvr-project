// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

/** Implementation of Solvr's parser, lexer and grammar */
library solvr_parser;

import 'dart:collection';

import 'package:solvr_ast/solvr_ast.dart';
import 'package:solvr_common/solvr_common.dart';
import 'package:solvr_matchers/solvr_matchers.dart';

import 'src/parser_api.dart';
export 'src/parser_api.dart';

part 'src/infix/assign_parselet.dart';
part 'src/infix/binary_parselet.dart';
part 'src/infix/postfix_unary_parselet.dart';

part 'src/prefix/brace_parselet.dart';
part 'src/prefix/bracket_parselet.dart';
part 'src/prefix/name_parselet.dart';
part 'src/prefix/nullary_parselet.dart';
part 'src/prefix/tuple_parselet.dart';
part 'src/prefix/prefix_unary_parselet.dart';

part 'src/solvr_grammar.dart';
part 'src/solvr_lexer.dart';
part 'src/solvr_parser.dart';
part 'src/solvr_precedence.dart';
part 'src/solvr_tokens.dart';

