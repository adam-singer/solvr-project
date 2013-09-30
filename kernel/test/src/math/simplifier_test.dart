// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class AutomaticSimplifierTest {
  AutomaticSimplifierTest() {
    group('automatic simplification -', () {
      test('addition', () {
        assertExpression('x+x', '2 * x');
        assertExpression('-x + x', '0');
        assertExpression('-x + -x', '-2 * x');
        assertExpression('x + 2*x', '3 * x');
        assertExpression('x + -3 * x', '-2 * x');
        assertExpression('x! + x!', '2 * x!');
        assertExpression('2*x + 3*x', '5 * x');
        assertExpression('3x! + 2x!', '5 * x!');
        assertExpression('x*y + y*x', '2 * x * y');
        assertExpression('2*x*y + y*x', '3 * x * y');
        assertExpression('2*z*x*y + 3*y*x*z + 4*x*z*y', '9 * x * y * z');
      });
      
      test('subtraction', () {
        assertExpression('x-x', '0');
        assertExpression('-x-x', '-2 * x');
        assertExpression('3*x - 2*x', 'x');
        assertExpression('4*x - x*2', '2 * x');
        assertExpression('x! - x!', '0');
        assertExpression('3x! - x!', '2 * x!');
        assertExpression('3x - 2x', 'x');
      });
      
      test('multiplication', () {
        assertExpression('x * 0', '0');
        assertExpression('x * y * 0 * z', '0');
        assertExpression('x * 1', 'x');
        assertExpression('1 * 1 * 1 * x', 'x');
        assertExpression('-1 * x * -1 * x^-1', '1');
        assertExpression('x*x', 'x^2');
        assertExpression('x * x^-1', '1');
        assertExpression('-x*-x', 'x^2');
        assertExpression('-x*x', '-x^2');
        assertExpression('x*-x', '-x^2');
        assertExpression('x*y', 'x * y');
        assertExpression('y*x', 'x * y');
        assertExpression('a^-1 * b * a', 'b');
        assertExpression('z*y*x', 'x * y * z');
        assertExpression('x*(3+1)', '4 * x');
        assertExpression('(x+1)x', 'x * (1 + x)');
        assertExpression('(a * b) * (c * b)', 'a * b^2 * c');
        assertExpression('c * 2 * b * c * a', '2 * a * b * c^2');
        assertExpression('(2*a*c*e) * (3*b*d*e)', '6 * a * b * c * d * e^2');
        assertExpression('(a * c * e) * (a * c^-1 * d * f)', 'a^2 * d * e * f');
      });

      test('fractions', () {
        assertExpression('x/x', '1');
        assertExpression('-x/-x', '1');
        assertExpression('-x/x', '-1');
        assertExpression('x/-x', '-1');
        assertExpression('(a*x^3)/x', 'a * x^2');
        assertExpression('(2 - x/x)*x', 'x');
      });
      
      test('factorials', () {
        assertExpression('x!', 'x!');
        assertExpression('x*x!', 'x * x!');
        assertExpression('y*x!', 'x! * y');
      });
      
      test('exponent expressions', () {
        assertExpression('x^0', '1');
        assertExpression('-x^0', '1');
        assertExpression('0^x', '0');
        assertExpression('1^x', '1');
        assertExpression('x^1', 'x');
        assertExpression('x^(3-2)', 'x');
        assertExpression('x^2', 'x^2');
        assertExpression('x^y', 'x^y');
        assertExpression('-x^y', '-x^y');
        assertExpression('x^-y', 'x^-y');
        assertExpression('-x^-y', '-x^-y');
        assertExpression('(x^2)^2', 'x^4');
        assertExpression('((x^(1/2))^(1/2))^8', 'x^2');
      });
      
      test('functions', () {
        assertExpression('f(y) + f(y)', '2 * f(y)');
        assertExpression('sin(x) + sin(x)', '2 * sin(x)');
        assertExpression('f(x) * f(x)', 'f(x)^2');
        assertExpression('sin(x) * sin(x)', 'sin(x)^2');
        assertExpression('f(y) * f(x)', 'f(x) * f(y)');
      });
      
      test('mixed operations', () {
        assertExpression('x*x^-1', '1');
        assertExpression('x*x^(-1)', '1');
        assertExpression('-x^-1 * -x', '1');
        assertExpression('x^2 * x^3', 'x^5');
        assertExpression('(x*y)*(x*y)^2', 'x^3 * y^3');
        assertExpression('(x-x)^3', '0'); 
        assertExpression('y^(3x - 2x - x + 1)', 'y');
        assertExpression('(x * y)^2', 'x^2 * y^2');
        assertExpression('(x * y)^(1/2)', 'x^1/2 * y^1/2');
        assertExpression('(x * y)^(1/2) * z', 'x^1/2 * y^1/2 * z');
        assertExpression('m * x + b', 'b + m * x');
      });
      
      test('polynomials', () {
        assertExpression('x^2 + x', 'x + x^2');
        assertExpression('x*x + x*x', '2 * x^2');
        assertExpression('2*x^2 + x^2', '3 * x^2');
        assertExpression('x*c + y^2 + x*b + 3 + x*a', '3 + a * x + b * x + c * x + y^2');
        assertExpression('2(x^2)^2 + 3(x^2)', '3 * x^2 + 2 * x^4');
      });
      
      test('tuples', () {
        assertExpression('(x + y)', 'x + y');
        assertExpression('(x + y)^2', '(x + y)^2');
        assertExpression('3(x + x)', '6 * x');
        assertExpression('3(y + x)', '3 * (x + y)');
        assertExpression('y*(-2 - 1)', '-3 * y');
        assertExpression('y*(2 - 2)', '0');
        assertExpression('(1 + x * 3)x', 'x * (1 + 3 * x)');
        assertExpression('(x + x, y - y)', '(2 * x,0)');
        assertExpression('(b + c) * 1 + a', 'a + b + c');
        assertExpression('(c * b) * 1 * a', 'a * b * c');
      });
    });
  }
}
