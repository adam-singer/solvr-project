// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_logic_test;

import 'package:dice/dice.dart';
import 'package:solvr_webapp/src/solvr_logic.dart';
import 'package:unittest/unittest.dart';

part 'src/logic/command_test.dart';

main() {
  var injector = new Injector(new MockDependenciesModule());
  var messageBus = injector.getInstance(MessageBus);
  var repository = injector.getInstance(ViewModelRepository);
 
  // tests
  new CommandTest(messageBus, repository);
}


