// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class ArithmeticOperatorTest {
  ArithmeticOperatorTest() {
    group('arithmetic operators test -', () {  
      test('literals', () {
        assertExpression('42', '42');
        assertExpression('-42', '-42');
      });
      
      test('fractions', (){
        assertExpression('10/10', '1');
        assertExpression('1/2', '1/2');
        assertExpression('6/3', '2');
        assertExpression('-6/-3', '2');
        assertExpression('-4/10', '-2/5');
        assertExpression('1/-3', '-1/3');
        assertExpression('-1/1', '-1');
        assertExpression('1/-1', '-1');
      });
      
      test('addition', () {
        assertExpression('31 + 11', '42');
        assertExpression('-25 + 93', '68');
        assertExpression('1/2 + 1/4', '3/4');
        assertExpression('1/2 + 1/2', '1');
        assertExpression('-1/2 + 1/2', '0');
        assertExpression('-1 + -1', '-2');
      });
      
      test('subtraction', () {
        assertExpression('43 - 79', '-36');
        assertExpression('-98 - 37', '-135');
        assertExpression('1 - 2 - 3', '-4');
        assertExpression('1/2 - 1/4', '1/4');
        assertExpression('1/2 - 1/2', '0');
        assertExpression('-1/2 - 1/2', '-1');
      });
      
      test('multiplication', () {
        assertExpression('2 * 8', '16');
        assertExpression('1 * -1', '-1');
        assertExpression('-1 * 1', '-1');
        assertExpression('-1 * -1', '1');
        assertExpression('-2 * -8', '16');
        assertExpression('-7 * 6', '-42');
        assertExpression('9 * -3', '-27');
        assertExpression('720 * 2', '1440');
        assertExpression('1/2 * 1/2', '1/4');
        assertExpression('3/2 * 2/3', '1');
        assertExpression('2*(-3)', '-6');
        assertExpression('2(-3)', '-6');
        assertExpression('2(-3 * -3)', '18');
      });
      
      test('exponent expressions', () {
        assertExpression('0^1', '0');
        assertExpression('1^3', '1');
        assertExpression('2^2', '4');
        // TODO assertExpression('4^(1/2)', '2');
        assertExpression('-1^-1', '-1');
        assertExpression('(-1)^(-1)', '-1');
        assertExpression('-2^2', '4');
        assertExpression('-3^2', '9');
        assertExpression('(-3)^3', '-27');
        assertExpression('-(2^2)', '-4');
        assertExpression('-3^2', '9');
        assertExpression('-3^3', '-27');
        assertExpression('2^-2', '1/4');
        assertExpression('-3^-3', '-1/27');
        /*
         * pow In[3]:= 2^1.3 Out[3]= 2.46229
         * 32^(1/4) 2*2^(1/4) 
         * -64^(1/4) (-2)*4^(1/4)
         * 540^(1/2) 6*15^(1/2) 
         * 75^(1/2)-27^(1/2) 2*3^(1/2) 
         * 12^(1/2)*8^(1/2)*98^(1/2) 56*3^(1/2) 
         * 2^(1/2)+1-2*3^(1/2)+4*2^(1/2)-3 -2*3^(1/2)+5*2^(1/2)-2 
         */
      });
      
      test('parentheses grouping', () {
        assertExpression('(2 - 3)', '-1');
        assertExpression('1 - (2 - 3)', '2');
      });
      
      test('factorials', () {
        assertExpression('1!', '1');
        assertExpression('2!', '2');
        assertExpression('3!', '6');
        assertExpression('6!', '720');
      });
      
      test('mixed operations', () {
        assertExpression('10 - 3 + 1', '8');
        assertExpression('(3*3 - 9)^3', '0');
        assertExpression('(3 * 3 * 3)^2', '729');
        assertExpression('2^3!', '64');
        assertExpression('(2^3)!', '40320');
        assertExpression('(2 + 3)!', '120');
        assertExpression('(2 + 4)!', '720');
        assertExpression('3(-3 + 5)', '6');
        assertExpression('-3(-3 + 5)', '-6');
        assertExpression('3!(-3 + 5)', '12');
        assertExpression('-3^2(-3 + 6)', '27');
        assertExpression('-3^2*(-3 + 6)', '27');
        assertExpression('-3^2 * (-2 + 5)', '27');
        assertExpression('(2 + 3)(-3 + 5)', '10');
        assertExpression('(2 + 4)! * (-3 + 5)', '1440');
        assertExpression('(2 + 3)!(-3 + 5)', '240');
        assertExpression('-2(2 + 3)(-3 + 5)', '-20');
        assertExpression('-3^(2(-3 + 5))', '81');
        assertExpression('-3^(2*(-3 + 5))', '81');
        assertExpression('-(3^(2*2))', '-81');
      });
    });
  }
}

