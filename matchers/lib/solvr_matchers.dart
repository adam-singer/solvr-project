// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

/**
 * AST expression matchers
 * 
 * We put these in their own library so they are not automatically imported when one uses the AST
 * library as these global matcher functions often clashes with build in Dart types
 */
library solvr_matchers;

import 'package:solvr_ast/solvr_ast.dart';

part 'src/binary_matcher.dart';
part 'src/nary_matcher.dart';
part 'src/nullary_matcher.dart';
part 'src/special_matcher.dart';
part 'src/unary_matcher.dart';

