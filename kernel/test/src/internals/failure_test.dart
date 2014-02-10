// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_internals_test;

/** Test failure handling */
class FailureTest {
  // TODO test position reporing 
  // TODO go through all instances of SolvrError and check that tests exists
  
  FailureTest() {
    group("failure test -", () {
      test('parse errors', () {
        //assertFailure("x == 1 < y != 2")
        //assertFailure("x in 1..10 | x^2");
        //assertFailure(".");
        //assertFailure("{1,}");
        //assertFailure("[[1,2];[3,4]]");
        //assertFailure("[[1 2];[3 4 5]]");
      });
      
      test('type errors', () {
        //assertFailure("true + 6"); 
        //assertFailure("7 && 6"); 
      });
      
      test('function errors', () {
        // TODO ensure that a single block of code checks all functions
        //assertFailure("gcd(2+3)");
      });
      
      // TODO figure out how to clasify these errors
      //assertFailure("1.x");
      //assertFailure("1 x");
      //assertFailure("!8");
    });
  }
  
  assertFailure(String expression, Matcher errorMatcher) {
    Expr expr;
    evaluate(String expr, Expr res) {
      var kernel = new Kernel();
      res = kernel.evaluate(expression);
    }
    expect(evaluate(expression, expr), errorMatcher, reason: 'expression [$expression] contains errors but evaluated successfully');
  }
}

