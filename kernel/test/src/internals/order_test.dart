// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_internals_test;

/** Tests the order realtion */
class OrderTest {
  OrderTest() {
    group("order test -", () {
      test("sums", () {
        assertOrder("a+b", "a+c", true);
        assertOrder("a+c+d", "b+c+d", true);
        assertOrder("c+d", "b+c+d", true);
      });
      
      test("numbers", () {
        assertOrder("1", "1", true);
        assertOrder("2", "3", true);
        assertOrder("3", "2", false);
      });
      
      test("symbols", () {
        assertOrder("a", "a", true);
        assertOrder("A", "B", true);
        assertOrder("a", "X", false);
        assertOrder("v1", "v2", true);
        assertOrder("v2", "v1", false);
        assertOrder("a1", "b1", true);
        assertOrder("y1", "x100", false);
      });
      
      test("products", () {
        assertOrder("a*b", "a*c", true);
        assertOrder("a*b", "a*b", true);
        assertOrder("a*c*d", "b*c*d", true);
        assertOrder("c*d", "b*c*d", true);
      });
      
      test("exponents", () {
        assertOrder("(1+x)^2", "(1+x)^3", true);
        assertOrder("(1+x)^3", "(1+y)", true);
        assertOrder("(1+x)^3", "(1+y)^2", true);
      });
      
      test("factorials", () {
        assertOrder("2!", "3!", true);
        assertOrder("2!", "x!", true);
        assertOrder("X!", "x!", true);
      });
      
      test("tuples", () { 
        assertOrder("(x)", "(x)", true);
        assertOrder("(x)", "(y)", true);
        assertOrder("(x+1)", "(y+1)", true);
        assertOrder("(x)", "(x,y)", true);
      });
      
      test("functions", () {
        assertOrder("f(x)", "g(x)", true);
        assertOrder("g(x)", "f(x)", false);
        assertOrder("f(x)", "f(y)", true);
        assertOrder("f(y)", "f(x)", false);
        assertOrder("g(x)", "g(x, y)", true);
        assertOrder("g(x, y)", "g(x)", false);
        assertOrder("g(y, z)", "g(x)", false);
        assertOrder("g(y, x)", "g(y, z)", true);
      });
      
      test("mixed operations", () {
        assertOrder("1", "a", true);
        assertOrder("2/3", "a", true);
        assertOrder("2", "a+b", true);
        assertOrder("1+a", "(b+c)", true);
        assertOrder("1+y", "x", false);
        assertOrder("5/2", "a/b", true);
        assertOrder("a * x^2", "x^3", true);
        assertOrder("(1+x)^3", "(1+y)", true);
        assertOrder("a * x^2", "x^3", true);
        assertOrder("-x", "x", true);
        assertOrder("-1 * x", "-1", false);
        assertOrder("2*x", "x", false);
        assertOrder("x", "x(t)", true);
        assertOrder("x", "y(t)", true);
        assertOrder("x", "sin(x)", false);
        assertOrder("1+a", "[a, b]", true);
        assertOrder("[1, a]", "[a; b; c]", true);
        assertOrder("a", "[[a; b; c]; [d; e; f]]", true);
        assertOrder("b", "{a,b,c,d,e,f,g,h,i}", true);
        assertOrder("[x; x^2]", "x", false);
      });
    });
  } 
  
  assertOrder(String exprStr1, String exprStr2, bool inOrder) {
    var expr1 = _kernel.evaluate(exprStr1);
    var expr2 = _kernel.evaluate(exprStr2);
    expect(Internal.isInOrder(expr1, expr2), equals(inOrder), reason:"expr1: $expr1 is not ordered $inOrder with: expr2 $expr2");
  }
  
  final _kernel = new Kernel.newScope();
}
