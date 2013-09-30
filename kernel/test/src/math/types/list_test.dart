// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class ListTest {
  ListTest() {
    group('list test -', () {
      test('correct structure', () {
        
      });
      
      test('errors', () {
        
      });
    });
    
    group('list test - operators', () {
      test('algebraic', () {
        // [1,2] * [1,2]
        // [1,2] + [1,2]
        // [1,2] - [1,2] = [0,0]
        // [3,4]!
        // [2,3]^2
        // x * [1,2]
      });
      
      // TODO use object operators to test interface structure (i.e. [1,2,3] is Algebraic)
    });
    
    group('list test - functions', () {
      
    });
    
    group('list test - interface method', () {
      // TODO call algebraic tester function (share with others)
      
      test("algebraic", () {
        //assertExpression("[1,2].getAt(1)", "1"); 
        //assertExpression("[1,2].add(3)", "[1,2,3]"); 
        //assertExpression("[1,3].addAt(1,2)", "[1,2,3]"); 
        //assertExpression("[1,2].removeAt(2)", "[1]"); 
        //assertExpression("[1,2].length()", "2"); 
        
        //assertExpression("[1,2,3].map((x) => x!)", "[1,2,6]");
        //assertExpression("[1,2,3].mapI((x,i) => (i+1)*x)", "[2,6,12]");
      });
      
      test("own methods", () {
        //assertExpression("[1,2,3].head()", "[1]");
        //assertExpression("[1,2,3].tail()", "[2,3]");
        //assertExpression("[1,2,3].reverse()", "[3,2,1]");
      });
    });
    
    group('list test - class method', () {
      test("methods", () {
        //assertExpression("[1,2,3].head()", "[1]");
        //assertExpression("[1,2,3].tail()", "[2,3]");
        //assertExpression("[1,2,3].reverse()", "[3,2,1]");
      });
    });
  }
}
