// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class AlgebraModuleTest {
  AlgebraModuleTest() {
    group("module (algebra)", () {
      // Coefficient
      test("coefficient", () {
        assertExpression("coefficient(3x^2 + x + 5, x, 2)", "3");
        assertExpression("coefficient(3x^2 + 4x + 5, x, 2)", "3");
        assertExpression("coefficient(a*x^2 + b*x + c, x, 2)", "a");
        assertExpression("coefficient(a*x + b*x + c, x, 1)", "a + b");
        assertExpression("coefficient(3*x^2 + 2*x^4, x^2, 2)", "0");
        assertExpression("coefficient(3*x^2 + 2*x^4, x^2, 1)", "3");
        assertExpression("coefficient(3*x^2 + 2*x^4, x^2, 0)", "2 * x^4");
        assertExpression("coefficient(3x*y^2 + 5x^2 * y + 7x + 9, x, 1)", "7 + 3 * y^2"); 
        assertExpression("coefficient(3x*y^2 + 5x^2 * y + 7x + 9, x, 3)", "0"); 
        assertExpression("coefficient(2x^2 + 3*x*y + 4*y^2 + 5x + 6y + 7, x, 1)", "5 + 3 * y");
        assertExpression("coefficient(coefficient(2x^2 + 3*x*y + 4*y^2 + 5x + 6y + 7, x, 1), y, 0)", "5");
        assertExpression("coefficient((3*sin(x))*x^2 + (2*ln(x)) * x + 4, x, 2)", "undefined");
      });
      
      //test("collect", () {
      //  assertExpression("collect(2axy+3bxy+4ax+5bx)", "abc");
      //});
      
      // Exponent
      test("degree", () {
        assertExpression("degree(3, x)", "0");
        assertExpression("degree(a*y + 5, y)", "1");
        assertExpression("degree(3x^2 + x + 5, x)", "2");
        assertExpression("degree(2*x^3, x)", "3");
        assertExpression("degree(3x^2 + 4x + 5, x)", "2");
        assertExpression("degree((x+1)(x+3), x)", "undefined");
      });
      
      // Denominator
      test("denominator", () {
        assertExpression("denominator(x^2 + 4x)", "1");
        //assertExpression("denominator(x/(x+1))", "x+1");
        assertExpression("denominator(j^(-n + 2))", "j^n");
        assertExpression("denominator(j^(-n * 2))", "1");
        assertExpression("denominator(j^(-2 - n))", "j^2 + n");
      });
      
      // Expand
      test("expand", () {
        // TODO assertExpression("expand((x+y)(x+y))", "x^2 + 2 * x * y + y^2");
        assertExpression("expand((a+b)^(2+n))", "(a + b)^2 * (a + b)^n");
        assertExpression("expand((x+y))", "x + y");
        assertExpression("expand(a*(b+c))", "a * b + a * c");
        assertExpression("expand(x*(x+y))", "x^2 + x * y");
        assertExpression("expand((x+y)^2)", "x^2 + 2 * x * y + y^2");
        assertExpression("expand((x^n)^m)", "x^m * n");
        assertExpression("expand(j^(2 + n))", "j^2 * j^n");
        assertExpression("expand(j^(-n + 2))", "j^2 * j^-n");
      });
      
      test("isPolynomial", () {
        assertExpression("isPolynomial(a*x^2*y^2, x)","true");
        assertExpression("isPolynomial(x^2 + y^2, {x, y})","true");
        assertExpression("isPolynomial(x^2 + y2, y)", "true");
        // TODO should this be true or false assertExpression("isPolynomial(x/(y+2y), {x,y})", "false");
        assertExpression("isPolynomial(x/(y+2y), x)", "true");
        assertExpression("isPolynomial((x + 1)*(x + 3), x)", "false");
      });
      
      //
      test("lcf", () {
        assertExpression("lcf(3x^2 + 4x + 5, x)", "3");
      });
      
      // Numerator
      test("numerator", () {
        assertExpression("numerator(x^2 + 4x)", "4 * x + x^2");
        //assertExpression("numerator(x/(x+1))", "x");
        assertExpression("numerator(j^(-n + 2))", "j^2");
        //assertExpression("numerator(j^(-n * 2))", "1");
        assertExpression("numerator(j^(-2 - n)))", "1");
      });
      
      // Together
      //test("normal", () {
        //TODO assertExpression("normal(1/a + 1/b)", "(a+b)/(a*b)");
        //TODO assertExpression("normal((x^2 - 1)/(x - 1))", "x+1");
        //TODO assertExpression("normal(1/(1/a + c/(a*b)) + (a*b*c + a*c^2)/(b + c)^2", "a");
      //});
      
      // Variables
      test("variables", () {
        assertExpression("variables(x^3 + 3x^2*y + 3x*y^2 + y^2)", "{x,y}");
        assertExpression("variables(3x*(x+1)*y^2*z^n)", "{x,y,z^n,1 + x}");
        assertExpression("variables(a * sin(x) + 2*b*sin(x) + 3c)", "{a,b,c,sin(x)}");
        assertExpression("variables(1/2)", "{}");
        // TODO assertExpression("variables(2^(1/2)*x^2 + 3^(1/2) * x + 5^(1/2) )", "{x, 2^(1/2), 3^(1/2), 5^(1/2)}");
      });
      
      //assertExpression("sumOf(x^2, x in 1..10)", "500");
      // symbolic sums sumIf(x^2, x in 1..n)
    });
  }
}
