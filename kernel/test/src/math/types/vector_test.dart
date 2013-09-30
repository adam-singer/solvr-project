// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class VectorTest {
  VectorTest() {
    group('vector operators -', () { 
      test('structure', () {
        assertExpression('[1; 2]', '[1; 2]');
        assertExpression('[1+2; 2*3]', '[3; 6]');
      });
      
      test('scalar multiplication', () {  
        assertExpression('x * [x*x; 1+2]', '[x^3; 3 * x]');
        assertExpression('x * [x; x^2]', '[x^2; x^3]'); 
        assertExpression('[x; x^2] * x', '[x^2; x^3]'); 
        assertExpression('2*[2; 4]', '[4; 8]');
        assertExpression('k*[a; b; c]', '[a * k; b * k; c * k]');
        assertExpression('[4; 5; 6] * 2', '[8; 10; 12]');
        assertExpression('-1 * [4; 5; 6]', '[-4; -5; -6]');
      });  
      
      test('addition', () {  
        assertExpression('[1; 2; 3] + [4; 5; 6]', '[5; 7; 9]');
      });
      
      test('subtraction', () {  
        assertExpression('[4; 5; 6] - [1; 2; 3]', '[3; 3; 3]');
        assertExpression('[2; 1] - [1; 1]', '[1; 0]');
      });
      
      test('dot product', () {  
        assertExpression('[1; 3; -5].[4; -2; -1]', '3');
        assertExpression('[1; 2; 3].[1; 2; 3]', '14');
        assertExpression('[1; 2; 3].[4; 5; 6]', '32');
        assertExpression('[a; b; c] . [d; e; f]', 'a * d + b * e + c * f');
      });
    });
    
    group('vector functions -', () {   
      test('constructor', () {
        // empty vector
        assertExpression('vector()', '[]');
        assertExpression('vector() is Vector', 'true');
        // single dimension vector
        assertExpression('vector(1)', '[1]');
        assertExpression('vector(1) is Vector', 'true');
        // multi dimension vector
        assertExpression('vector(1,2)', '[1 2]');
        assertExpression('vector(1,2) is Vector', 'true');
      });
      
      // CrossProduct[{1, 3, 5}, {-4, 7, 1}]
      // {1,2,3} cross {1,2,3} = {0, 0, 0}
      // {1,2} cross {1,2} -> fail cross product only defined for 3 dimensions
    
      //assertExpression('Norm[{1,2}]', 'sqrt(5)');
    });
    
    group('vector failures -', () {  
    });
    
    group('vector methods -', () {  
      // TODO index vectors v = {a, b, c, d} => v.get(1) = a
      // TODO test failures with negative indexes
    });
  }
}

