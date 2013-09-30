// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_internals_test;

/** Test registration of types and functions */
class RegistryTest {
  RegistryTest() {
    var registry = new Internal.Registry();
    var areas;
    
    group('registry test -', () {
      test("number of areas",() {
        areas = registry.areas;
        expect(areas.length, equals(4));
      });
      
      test("functions in areas", () {
        areas.forEach((var area) {
          var functions = registry.getFunctionsFor(area);
          functions.forEach((name,list) {
            expect(list.isEmpty, isFalse, reason:"no functions found for $name");
          });
        });
      });
    });
  }
}
