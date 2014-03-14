// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

/** Test type checker */
library solvr_type_checker_test;

import 'package:solvr_ast/solvr_ast.dart';
import 'package:solvr_common/solvr_common.dart';
import 'package:solvr_parser/solvr_parser.dart';
import 'package:solvr_matchers/solvr_matchers.dart' as Matchers;
import 'package:unittest/unittest.dart';

part 'src/type_checker_test.dart';

main() {
  LoggerFactory.config['.*'].debugEnabled = false;

  new TypeCheckerTest();
}

