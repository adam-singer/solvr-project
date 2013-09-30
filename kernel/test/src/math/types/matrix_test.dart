// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class MatrixTest {
  MatrixTest() {
    group("matrix operations", () { 
      test("addition", () {  
        assertExpression("[[1; 3]; [1;  0]] + [[0; 0]; [7; 5]]", "[[1; 3];[8; 5]]");
      });
      
      test("structure", () {
        assertExpression("[[1; 2]; [3; 4]]", "[[1; 2];[3; 4]]");
        assertExpression("[[1+1; 2+1]; [3+1; 4+1]]", "[[2; 3];[4; 5]]");
      });

      test("scalar multiplication", () {  
        assertExpression("x * [[1; 2]; [3; 4]]", "[[x; 2 * x];[3 * x; 4 * x]]");
        assertExpression("[[1+1; 2+1]; [3+1; 4+1]] * x", "[[2 * x; 3 * x];[4 * x; 5 * x]]");
      });  
      
      // TODO scalar addition and subtraction
      
      test("addition", () {  
        // TODO p. 70 manga linear alg
        assertExpression("[[1; 3]; [1;  0]] + [[0; 0]; [7; 5]]", "[[1; 3];[8; 5]]");
      });
      
      test("subtraction", () {  
        assertExpression("[[1; 3]; [8; 5]] - [[0; 0]; [7; 5]]", "[[1; 3];[1; 0]]");
      });
      
      test("dot product", () {  
        assertExpression("[[1; 3]; [1; 0]] . [[0; 0]; [7; 5]]", "[[1; 3];[8; 5]]");
      });
    });
    
    group("matrix functions", () { 
      expect(false, isTrue);
    });
    
    group("mixed matrix expressions", () {
      expect(false, isTrue);
      /*
        Products of matrix and vectors:
        {{a, b}, {c, d}} . {x, y}
        {x, y} . {{a, b}, {c, d}}
        {x, y} . {{a, b}, {c, d}} . {r, s}
        
         // [[1  2]; [3, 4]] * (1 + a) 
      */
    });
    
    group("matrix methods", () {
      assertExpression("[[1 2]; [3,4]].get(1)", "[1 2]"); 
      assertExpression("[[1 2]; [3,4]].get(1,1)", "1"); 
    
      // TODO test failures with negative indexes
      // TODO matrices {{1, 2}, {3, 4}}.{{1, 2}, {3, 4}} vs {{1, 2}, {3, 4}} * {{1, 2}, {3, 4}}
      // TODO index matrices m = {{a, b}, {c, d}} => m[1] = {a,b}
      // TODO vector and matrice multiplication http://reference.wolfram.com/mathematica/tutorial/MultiplyingVectorsAndMatrices.html
    });
  }
}

