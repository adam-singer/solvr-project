// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

library solvr_common_test;

import 'package:meta/meta.dart';
import 'package:unittest/unittest.dart';
import '../lib/solvr_common.dart';

part 'src/helpers_test.dart';
part 'src/integer_test.dart';

void main() {
  new HelpersTest();
  new IntegerTest();
}

