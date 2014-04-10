// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

library solvr_webapp_test;

import 'package:solvr_common/solvr_common.dart';
import 'package:unittest/unittest.dart';
import 'package:solvr_webapp/solvr_webapp.dart';

part 'src/webapp/folder_test.dart';
part 'src/webapp/notebook_test.dart';
part 'src/webapp/presenter_test.dart';
part 'src/webapp/search_test.dart';
part 'src/webapp/settings_test.dart';
part 'src/webapp/user_test.dart';

main() {
  LoggerFactory.config['.*'].debugEnabled = false;
  
  //new NotebookTest();
  //new UserTest();
}

