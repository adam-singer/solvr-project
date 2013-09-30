// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

/** test parser and lexer */
library solvr_kernel_parser_test;

import 'package:solvr_common/solvr_common.dart';
import 'package:unittest/unittest.dart';

import 'package:solvr_kernel/src/ast_lib.dart';
import 'package:solvr_kernel/src/matcher_lib.dart' as Matchers;
import 'package:solvr_kernel/src/parser_lib.dart';

part 'src/parser/lexer_test.dart';
part 'src/parser/parser_test.dart';

main() {
  LoggerFactory.config['.*'].debugEnabled = false;

  //new LexerTest();
  new ParserTest();
}

