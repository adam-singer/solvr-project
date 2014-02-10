// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_kernel_internals_test;

/** Test scoping and value lookup */
class ResolverTest {  
  ResolverTest() {
    group("resolve test -", () {
      test("method lookup", () {
        assertExpressionType("[1 2].length()", Matchers.isMethod); 
      });
      
      test("symbol scope", () {
        // TODO test via multiline expressions
        assertExpressionValue("x = 2", "x + 1 == 3"); 
      });
      
      test("function scope", () {
        // assertExpressionValue("square(x) = x^2", "square(2) == 4"); 
        
        // { x in [1,10] | sqare(x) }     => ListExpr(GeneratorExpr) with GeneratorExpr(left = fn, right = list of "in expressions")
        // 1,4,9,16,....
        
        // halfOf(x) = halfOf(x, 2);
        // halfOf(5) = 2
        
        // composition(x) = halfOf(square(x))
        // composition(4) = 8
        
        
        // p(n) = { n, prime(n) }
        // p(2) = {2,3}
        
        // { n in [1,10] | p(n) }
        // res = {{1,1}, {2,2}, {3,3}, {4,5}, {5, 7}, {6, 11}, ...}
        
        // anonymous
        // {x in [1,10] | (x) => { x, x^2 }}
      });
    });
  }
  
  assertExpressionType(String expression, ExprMatcher matcher) {
    var expr = _kernel.parse(expression);
    expr = _kernel.resolve(expr);
    expect(matcher(expr), isTrue, reason:"type comparison failes on instance $expr");
  }
  
  assertExpressionValue(String expr1, String expr2) {
    _kernel.resetScope();
    _kernel.evaluate(expr1);
    BoolExpr result = _kernel.evaluate(expr2);
    expect(Matchers.isBool(result), isTrue, reason:"type comparison failes on result $result");
    expect(result.value, isTrue, reason:"value comparison failes for ${result.value}");
  }
  
  final Kernel _kernel = new Kernel();
}
