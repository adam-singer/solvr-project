// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

library solvr_logic_test;

import 'package:solvr_webapp/src/solvr_logic.dart';
import 'package:unittest/unittest.dart';

part 'src/logic/command_test.dart';

main() {
  bindMockLogic().then((config) {
    new CommandTest(config);
  });
}


