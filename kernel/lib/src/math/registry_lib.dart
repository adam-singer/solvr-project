// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

library solvr_kernel_math_registry;

import 'dart:collection';

import 'internals_lib.dart';

// begin function imports
import 'functions/algebra_lib.dart';
import 'functions/builtin_lib.dart';
import 'functions/calculus_lib.dart';
import 'functions/number_theory_lib.dart';
// end function imports

part 'registry/loader.dart';
part 'registry/registry.dart';
part 'registry/scope.dart';

// begin modules
part 'registry/modules/algebra_module.dart';
part 'registry/modules/builtin_module.dart';
part 'registry/modules/calculus_module.dart';
part 'registry/modules/combinatorics_module.dart';
part 'registry/modules/complex_module.dart';
part 'registry/modules/finance_module.dart';
part 'registry/modules/geometry_module.dart';
part 'registry/modules/graph_theory_module.dart';
part 'registry/modules/linear_algebra_module.dart';
part 'registry/modules/number_theory_module.dart';
part 'registry/modules/optimization_module.dart';
part 'registry/modules/probability_module.dart';
part 'registry/modules/set_theory_module.dart';
part 'registry/modules/statistics_module.dart';
part 'registry/modules/trigonometry_module.dart';
// end modules

