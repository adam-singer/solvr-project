// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast_test;

class VisitorTest {
  VisitorTest() {
    /*
    group("binary expressions -", () {
      test("sum", () {
        var number1 = Expr.number(null,"1");
        var number2 = Expr.number(null,"2");
        var sumExpr = Expr.sum(null,number1, number2);
        
        sumExpr.visit(visitor);
        expect(visitor.asString, equals("1 + 2"));  
      });
    });
    */
    
    group("nullary expressions -", () {
      test("bool", () {
        assertExpression(asBool(true), "true");
        assertExpression(asBool(false), "false");
      });
      
      test("number", () {
        assertExpression(asInteger("1"), "1");
        assertExpression(asInteger(new Integer("1")), "1");
        assertExpression(asInteger(1), "1");
        assertExpression(asReal("3.14"), "3.14");
      });
      
      test("string", () {
        assertExpression(stringOf(""), '\"\"');
        assertExpression(stringOf("hello"), '\"hello\"');
        assertExpression(stringOf("hello world"), '\"hello world\"');
      });
      
      test("symbol", () {
        assertExpression(asSymbol("x"), "x");
      });
    });
  }
  
  assertExpression(Expr expr, String expected) {
    visitor.clear();
    expr.visit(visitor);
    //print(visitor.asString());
    expect(visitor.asString(), equals(expected));
  }
  
  final visitor = new StringBufferVisitor();
}
