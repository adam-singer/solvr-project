// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class DictionaryTest {
  DictionaryTest() {
    group('dictionary operators -', () { 
      fail('TODO implement dictionary operators tests');
    });
    
    group('dictionary functions -', () { 
      fail('TODO implement dictionary function tests');
    });
    
    group('dictionary methods -', () { 
      test('collection api', () {
        assertExpression("{x:1}.has(x)", "true"); 
        assertExpression("{x:1,y:2}.get(y)", "2"); 
        assertExpression("{x:1,y:2,z:3}.length()", "3"); 
        assertExpression("{x:1,y:2,z:3}.map((k,v) => k:(v+1)", "{x:2,y:3,z:4}");
      });
    });
    
    group('dictionary failures -', () { 
      fail('TODO implement dictionary failure tests');
      // failure test
      // { 1:a }
      // 3 * { a:1 }
    });
  }
}






