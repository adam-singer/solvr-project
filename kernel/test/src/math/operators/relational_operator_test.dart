// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class RelationalOperatorTest {
  RelationalOperatorTest() {
    group('relational operators test -', () {       
      test('equals', () {
        assertExpression('8 == 7', 'false');
        assertExpression('0 == -0', 'true');
        assertExpression('x == 8', 'x == 8');
        assertExpression('x == y', 'false');
        assertExpression('x == x', 'true');
        assertExpression('(x + x) == x*2', 'true');
      });
      
      test('not-equals', () {
        assertExpression('7 != 8', 'true');
        assertExpression('7 != 7', 'false');
        assertExpression('0 != -0', 'false');
        assertExpression('x != 8', 'x != 8');
        assertExpression('x != x', 'false');
        assertExpression('x != y', 'true');
        assertExpression('(x + x) != x*2', 'false');
      });
      
      test('less than', () {
        assertExpression('17 < 18', 'true');
        assertExpression('20 < 20', 'false');
        assertExpression('1 + 3 < 2 + 4', 'true');
        assertExpression('x < 17', 'x < 17');
        assertExpression('x < y', 'x < y');
        assertExpression('x < x', 'false');
      });
      
      test('less than or equals', () {
        assertExpression('117 <= 117', 'true');
        assertExpression('x <= x', 'true');
      });
      
      test('greater than', () {
        assertExpression('18 > 17', 'true');
        assertExpression('20 > 20', 'false');
        assertExpression('1 - 2 > 3 - 4', 'false');
        assertExpression('1 + 3 > 2 + 4', 'false');
        assertExpression('x > 17', 'x > 17');
        assertExpression('x > y', 'x > y');
        assertExpression('x > x', 'false');
      });
      
      test('greater than or equals', () {
        assertExpression('117 >= 117', 'true');
        assertExpression('x >= x', 'true');
      });
    });
  }
}
