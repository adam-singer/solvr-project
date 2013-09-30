// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_common_test;

import 'package:unittest/unittest.dart';
import 'package:solvr_common/solvr_common.dart';

part 'src/helpers_test.dart';
part 'src/integer_test.dart';

main() {
  new HelpersTest();
  new IntegerTest();
}

