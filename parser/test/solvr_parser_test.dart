// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

/** test parser and lexer */
library solvr_parser_test;

import 'package:solvr_ast/solvr_ast.dart';
import 'package:solvr_common/solvr_common.dart';
import 'package:solvr_parser/solvr_parser.dart';
import 'package:solvr_matchers/solvr_matchers.dart' as Matchers;
import 'package:unittest/unittest.dart';

part 'src/lexer_test.dart';
part 'src/parser_test.dart';

main() {
  LoggerFactory.config['.*'].debugEnabled = false;

  new LexerTest();
  new ParserTest();
}

