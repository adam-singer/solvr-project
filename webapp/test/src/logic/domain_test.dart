// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_logic_test;

class DomainTest {
  DomainTest() {
    group('domain replay', () {
      // TODO load file with events and reapply them to the domain
      // - ensure failure if another user is siged in
      // - ensure failure if domain rules are violated (deleteing undeletable, moving unmovalbe, changing other users note,...)
    });
  }
}