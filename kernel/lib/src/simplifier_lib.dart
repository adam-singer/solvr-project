// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_kernel_math_simplifier;

import 'registry_lib.dart';
import 'internals_lib.dart';

part 'simplifier/reducer/algebraic/difference_reducer.dart';
part 'simplifier/reducer/algebraic/dot_reducer.dart';
part 'simplifier/reducer/algebraic/factorial_reducer.dart';
part 'simplifier/reducer/algebraic/fraction_reducer.dart';
part 'simplifier/reducer/algebraic/number_reducer.dart';
part 'simplifier/reducer/algebraic/power_reducer.dart';
part 'simplifier/reducer/algebraic/product_reducer.dart';
part 'simplifier/reducer/algebraic/sum_reducer.dart';
part 'simplifier/reducer/algebraic/tuple_reducer.dart';

part 'simplifier/reducer/invoke_reducer.dart';
part 'simplifier/reducer/logical_reducer.dart';
part 'simplifier/reducer/object_reducer.dart';
part 'simplifier/reducer/relational_reducer.dart';
part 'simplifier/reducer/reducer.dart';
part 'simplifier/reducer/set_reducer.dart';
part 'simplifier/reducer/trig_reducer.dart';

part 'simplifier/automatic_simplifier.dart';
part 'simplifier/rational_simplifier.dart';


