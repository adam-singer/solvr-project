// Copyright (c) 2013 Solvr. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

/**
 * AST expression matchers
 * 
 * We put these in their own library so they are not automatically imported when one uses the AST
 * library as these global matcher functions often clashes with build in Dart types
 */
library solvr_kernel_matcher;

import 'ast_lib.dart';

part 'matcher/binary_matcher.dart';
part 'matcher/nary_matcher.dart';
part 'matcher/nullary_matcher.dart';
part 'matcher/special_matcher.dart';
part 'matcher/unary_matcher.dart';

