// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class BuiltinModuleTest {
  BuiltinModuleTest() {
    group("module (builtin)", () {
      // Apply
      /*
      test("construct", () {
        //assertExpression("construct([a,b,c], (e1,e2) => e1 + e2)", "a + b + c");
        //assertExpression("construct([a+b,c+d,e+f], (e1,e2) => (e1) * (e2))", "(a+b) * (c+d) + (e+f)");
        //assertExpression("g(construct([a,b,c], (e1,e2) => e1 + e2))", "g(a + b + c)");
      });
      */
      
      // Factors
      test("factors", () {
        // p 148
        assertExpression("factors((c*x*sin(x))/2, x)", "[1/2 * c,sin(x) * x]");
      });  
      
      // FreeQ
      test("freeOf", () {
        assertExpression("freeOf(a+b, b)", "false");
        assertExpression("freeOf(a+b, c)", "true");
        assertExpression("freeOf((a+b) * c, a + b)", "false");
        assertExpression("freeOf(sin(x) + 2*x, sin(x))", "false");
        assertExpression("freeOf((a+b+c)*d, a+b)", "true");
        assertExpression("freeOf((y+2 * x-y)/x, x)", "true");
        assertExpression("freeOf((x*y)^2, x*y)", "true");
        assertExpression("freeOf(sin(x), ln(sin(x)))", "true");
        assertExpression("freeOf(x, ln(sin(x)))", "true");
        assertExpression("freeOf(x, sin(x))", "true");
        assertExpression("freeOf(x^4, x^2)", "true");
      });
      
      // Hold
      test("hold", () {
        assertExpression("hold(2+2)", "2 + 2");
      });
      
      // Length
      test("length", () {
        assertExpression("length(m * x + b)", "2");
        assertExpression("length(f(x,y))", "2");
        assertExpression("length({a,b,c,d})", "4");
        assertExpression("length(n!)", "1");
        assertExpression("length(x)", "undefined");
        assertExpression("length(a - b - c * d)", "3");
      });
      
      // Part
      test("operand", () {
        assertExpression("operand(x * m + b, 2)", "m * x");
        assertExpression("operand(x^2,1)", "x");
        assertExpression("operand(operand(x * m + b, 2), 2)", "x");
        assertExpression("operand({a,b,c,d},2)", "b");
        assertExpression("operand(x-x, 1)", "undefined");
        assertExpression("operand(a/(-3), 2)", "a");
      });
      
      // Parts
      test("operands", () {
        assertExpression("operands(x * m + b)", "[b,m * x]");
        assertExpression("operands(x^2)", "[x,2]");
        assertExpression("operands({a,b,c,d})", "[a,b,c,d]");
        assertExpression("operands(x-x)", "undefined");
        assertExpression("operands(a/(-3))", "[-1/3,a]");
      });
      
      // Head
      test("typeOf", () {
        assertExpression("typeOf(x)", "Symbol");
        assertExpression("typeOf(3)", "Number");
        assertExpression("typeOf(2.1)", "Number");
        assertExpression("typeOf(pi)", "Symbol");
        assertExpression("typeOf(m*x+b)", "+");
        assertExpression("typeOf((a+b) * sin(x^2))", "*");
        assertExpression("typeOf(a/b)", "*");
        assertExpression("typeOf(2/3)", "Number");
        assertExpression("typeOf(sin(x))", "sin");
        assertExpression("typeOf(1 == b)", "==");
        assertExpression("typeOf({a,b,c,d})", "Set");
        assertExpression("typeOf([a,b,c,d])", "List");
        assertExpression("typeOf(a && b)", "&&");
        assertExpression("typeOf(x - x + 2)", "Number");
      });
      
      // ReplaceAll
      test("replace", () {
        assertExpression("replace(a+b, b:=x)", "a + x");
        assertExpression("replace(1/a + a, a:=x)", "x^-1 + x");
        assertExpression("replace((a+b)^2 + 1, a+b:=x)", "1 + x^2");
        assertExpression("replace(a+b+c, a+b:=x)", "a + b + c");
        assertExpression("replace(a+b+c, a:=x-b)", "c + x");
        assertExpression("replace(x+y, [x:=a+1, y:=b+2])", "3 + a + b");
        assertExpression("replace(x+y, [x:=a+1, a:=b+2])", "3 + b + y");
        //TODO assertExpression("replace(f(x) = a*x+b, [f(x):=2, x:=3])", "2 = 3 * a + b");
        //TODO assertExpression("replace(f(x) = a*x+b, [x:=3, f(x):=2])", "2 = 3 * a + b");
        assertExpression("replace((a+b)*x, [a+b:=x+c, x:=d])", "d * (c + d)");
        assertExpression("replace(x*(x+y), [x:=2, x + y:=3])", "2 * (2 + y)"); 
        assertExpression("replace(x + y*2, [x:=y, y:=x])", "3 * x"); 
        assertExpression("replace(a+b+c, [a:=b,b:=c,c:=a])", "3 * a");  
      });
      
      test("substitute", () {
        assertExpression("substitute((a+b)*x, {a+b:=x+c, x:=d})", "d * (c + x)");
        // TODO assertExpression("substitute(f(x) = a * x + b, {x:=3, f(x):=2})", "2 = 3 * a + b");
        assertExpression("substitute(x*(x+y), {x := 2, x + y := 3})", "6"); 
        assertExpression("substitute(x + y*2, {x := y, y := x})", "2 * x + y"); 
        assertExpression("substitute(a+b+c, {a:=b,b:=c,c:=a})", "a + b + c"); 
      });
    });  
    
    // TODO check that when function is defined and not used in function style then an error is thrown (f(x) = x^2 \n f + 3 = error should be f(something) + 3)
    
    // TODO syntaxTree(2+2) - integrate with SVG and test in interface
    
    // TODO test function matching (used in tab completion), fx. functionMatch("do") should show "dotProduct" as possible match
    
    /*
    29. exp(2) 7.3890561 7.38905609893065
    30. ceil(4.2) 5 5
    31. floor(4.8) 4 4
    34. roundTo(0.015,2) 0.02 0.02
    47. randomBetween(1,10,2) N/A 1.44
    48. maxn(1,10,100) 100 100
    49. minn(1,10,100) 1 1
    50. avg(1,10,100) 37 37
    51. Expand((x+1)*(x+2)) x^2+3*x+2 x^2+3*x+2
    52. Expand((2-3^(1/2))*(1+2*3^(1/2))) 3*3^(1/2)-4 3*3^(1/2)-4
    53. Factor(x^2+3*x+2) (x+1)*(x+2) (x+1)*(x+2)
    */
  }
}
