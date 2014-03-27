// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_analyzer_test;

import 'package:solvr_ast/solvr_ast.dart';
import 'package:solvr_common/solvr_common.dart';
import 'package:solvr_parser/solvr_parser.dart';
import 'package:solvr_analyzer/solvr_analyzer.dart';
import 'package:unittest/unittest.dart';

part 'src/analyzer_test.dart';
part 'src/binary_expr_analyzer_test.dart';
part 'src/nary_expr_analyzer_test.dart';
part 'src/nullary_expr_analyzer_test.dart';
part 'src/special_expr_analyzer_test.dart';
part 'src/unary_expr_analyzer_test.dart';

main() {
  LoggerFactory.config['.*'].debugEnabled = false;

  new BinaryExprAnalyzerTest();
  new NaryExprAnalyzerTest();
  new NullaryExprAnalyzerTest();
  new SpecialExprAnalyzerTest();
  new UnaryExprAnalyzerTest();
}

