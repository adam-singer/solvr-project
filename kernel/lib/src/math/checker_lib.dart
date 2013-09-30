// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

library solvr_kernel_math_checker;

import 'registry_lib.dart';
import 'internals_lib.dart';

part 'checker/checkers/algebraic_checker.dart';
part 'checker/checkers/checker.dart';
part 'checker/checkers/logical_checker.dart';
part 'checker/checkers/object_checker.dart';
part 'checker/checkers/relational_checker.dart';
part 'checker/checkers/set_checker.dart';

part 'checker/type_checker.dart';
part 'checker/type_exception.dart';

/** Return true if a type is matched by the function */
typedef bool TypeMatcher(IType type);
