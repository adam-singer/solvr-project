// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

/**
 * Type checker for the Solvr language
 */
library solvr_type_checker;

import 'package:solvr_ast/solvr_ast.dart';
//import 'package:solvr_common/solvr_common.dart';
import 'package:solvr_matchers/solvr_matchers.dart';

// TODO can these be made private ?
part 'src/visitor/binary_expr_type_visitor.dart';
part 'src/visitor/nary_expr_type_visitor.dart';
part 'src/visitor/nullary_expr_type_visitor.dart';
part 'src/visitor/special_expr_type_visitor.dart';
part 'src/visitor/unary_expr_type_visitor.dart';

part 'src/checkers/algebraic_checker.dart';
part 'src/checkers/checker.dart';
part 'src/checkers/logical_checker.dart';
part 'src/checkers/object_checker.dart';
part 'src/checkers/relational_checker.dart';
part 'src/checkers/set_checker.dart';

part 'src/type_checker.dart';
part 'src/type_visitor.dart';
