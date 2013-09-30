// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class SeqTest {
  SeqTest() {
    group("sequences", () {
      test("independent term", () {
        assertExpression("{1..5 | x^2}", "[x^2,x^2,x^2,x^2,x^2]");
      });
      
      test("one term", () {
        assertExpression("{i in 1..5 | x^i }", "");
        // test that automatic simplification is applied to the result
        assertExpression("{i in 1..5 | (x+x)^i }", "");
      });
      
      test("multiple terms", () {
        assertExpression("{i in 1..4, j in 1..3 | 10i + j}", ""); 
        assertExpression("matrix( {i in 1..4, j in 1..3 | 10i + j} )", ""); 
      });
      
      test("dependent terms", () {
        assertExpression("{n in 0..5, k in 0..n | binomial(n,k)}", "");
        assertExpression("{x in 1..5, y in 1..y | x^y}", "");
      });
    });
  }
}
