// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

/** test kernel internals  */
library solvr_kernel_internals_test;

import 'package:solvr_common/solvr_common.dart';
import 'package:unittest/unittest.dart';

import 'package:solvr_kernel/solvr_kernel.dart';
import 'package:solvr_kernel/src/math_lib.dart' as Internal;
import 'package:solvr_matchers/solvr_matchers.dart' as Matchers;

part 'src/internals/failure_test.dart';
part 'src/internals/order_test.dart';
part 'src/internals/registry_test.dart';
part 'src/internals/resolver_test.dart';

main() {
  //_testAll();
  _testSingle();
}

_testAll() {
  LoggerFactory.config['.*'].debugEnabled = false;
  
  new FailureTest();
  new OrderTest();
  new RegistryTest();
  new ResolverTest();
}

_testSingle() {
  LoggerFactory.config['.*'].debugEnabled = false;
  LoggerFactory.config['solvr_kernel.*'].debugEnabled = true;
  LoggerFactory.config['solvr_function.*'].debugEnabled = true;
  LoggerFactory.config['solvr_registry.*'].debugEnabled = true;
  
  new RegistryTest();
  new OrderTest();
}

