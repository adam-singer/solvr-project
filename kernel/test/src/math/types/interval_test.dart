// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class IntervalTest {
  // TODO http://en.wikipedia.org/wiki/ISO_31-11
  
  IntervalTest() {
    group('interval operators -', () { 
      fail('TODO implement interval operators tests');
      // 1..10 = 1..10
      // x in 1..10 = x in 1..10
      // 2 in 1..10 = true
      // 0 in 1..10 = false
    });
    
    group('interval methods -', () { 
      fail('TODO implement interval methods tests');
      // expand(1..10) = {1,2,3, ... 10}
    });
  }
}
