// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class LogicOperatorTest {
  LogicOperatorTest() {
    group('logical operators test -', (){
      test('literals', () {
        assertExpression('true', 'true');
        assertExpression('false', 'false');
      });
      
      test('negation', () {
        assertExpression('!false', 'true');
        assertExpression('!true', 'false');
      });
      
      test('and', () {
        assertExpression('false && false', 'false');
        assertExpression('true && false', 'false');
        assertExpression('false && true', 'false');
        assertExpression('true && true', 'true');
      });
      
      test('or', () {
        assertExpression('false || false', 'false');
        assertExpression('true || false', 'true');
        assertExpression('false || true', 'true');
        assertExpression('true || true', 'true');
      });
      
      test('comparison', () {
        assertExpression('true == false', 'false');
        assertExpression('false != true', 'true');
      });
      
      test('mixed operations', () {
        assertExpression('false || true && false', 'false');
        assertExpression('false && true || true && false', 'false');
        assertExpression('false || !false && true', 'true');
        assertExpression('true || true && false || !false', 'true');
      });
    });
  }
}
