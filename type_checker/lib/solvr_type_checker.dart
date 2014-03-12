// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_type_checker;

//import 'registry_lib.dart';
//import 'internals_lib.dart';
import 'package:solvr_ast/solvr_ast.dart';
//import 'package:solvr_common/solvr_common.dart';
import 'package:solvr_matchers/solvr_matchers.dart';

part 'src/checkers/algebraic_checker.dart';
part 'src/checkers/checker.dart';
part 'src/checkers/logical_checker.dart';
part 'src/checkers/object_checker.dart';
part 'src/checkers/relational_checker.dart';
part 'src/checkers/set_checker.dart';

part 'src/type_checker.dart';
part 'src/type_exception.dart';

/** Return true if a type is matched by the function */
typedef bool TypeMatcher(IType type);
