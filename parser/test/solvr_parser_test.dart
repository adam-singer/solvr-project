// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

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

