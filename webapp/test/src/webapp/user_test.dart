// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_webapp_test;

class UserTest extends PresenterTest {
  UserTest() {
    group('initial user:', () {
      test('initially user should have default settings', () {  
        Settings settings = SessionContext.currentUser.settings;
        expect(settings, isNotNull);
        expect(settings.showToolTips, isTrue);
        expect(settings.automaticSimplify, isTrue);
      });
    });
  }
}
