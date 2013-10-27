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
    
    group("nary expressions -", () {
      test("product", () {
        assertExpression(asInteger(2) * asInteger(2), "2 * 2");
        assertExpression(asProduct([negative(asInteger(2)), asInteger(3)]) , "-2 * 3");
      });
      
      test("sum", (){
        assertExpression(asInteger(2) + asInteger(2), "2 + 2");
        assertExpression(asSum([asInteger(2), asInteger(3)]) , "2 + 3");
      });
      
      test("list", () {
        assertExpression(asList([]), "[]"); 
        assertExpression(asList([asInteger(1)]), "[1]"); 
        assertExpression(asList([asInteger(1), asInteger(2)]), "[1,2]"); 
      });
      
      test("matrix", () {
        var vec1 = asVector([asInteger(1), asInteger(2)]);  
        var vec2 = asVector([asInteger(3), asInteger(4)]);  
        assertExpression(asMatrix([vec1, vec2]), "[[1; 2];[3; 4]]");
      });
      
      test("set", () {
        assertExpression(asSet([]), "{}"); 
        assertExpression(asSet([asInteger(1)]), "{1}"); 
        assertExpression(asSet([asInteger(1), asInteger(2)]), "{1,2}"); 
      });
      
      test("tuple", () {
        assertExpression(asTuple([]), "()"); 
        assertExpression(asTuple(asInteger(1)), "(1)"); 
        assertExpression(asTuple([asInteger(1), asInteger(2)]), "(1,2)"); 
      });
      
      test("vector", () {
        assertExpression(asVector([]), "[]"); 
        assertExpression(asVector([asInteger(1)]), "[1]"); 
        assertExpression(asVector([asInteger(1), asInteger(2)]), "[1;2]"); 
      });
      
      test("dictionary", () {
        assertExpression(asDictionary([]), "{}"); 
        assertExpression(asDictionary([entry(stringOf("key1"), stringOf("val1"))]), '{\"key1\":\"val1\"}'); 
        assertExpression(asDictionary([entry(stringOf("key1"), stringOf("val1")),
                                       entry(stringOf("key2"), stringOf("val2"))]), '{\"key1\":\"val1\",\"key2\":\"val2\"}');
      });
      
      test("interval", () {
        assertExpression(asInterval(asInteger(1), asNothing(), asInteger(10)), "1..10");  
        assertExpression(asInterval(asInteger(1), asInteger(10), asInteger(100)), "1..10..100");  
      });
    });
    
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
    
    group("unary expressions -", () {
      test("factorial", () {
        assertExpression(factorial(asInteger(3)), "3!");
      });
      
      test("negation", () {
        assertExpression(negation(asBool(true)), "!true");
      });
      
      test("negative", () {
        assertExpression(negative(asInteger(3)), "-3");
      });
    });
  }
  
  assertExpression(Expr expr, String expected) {
    visitor.clear();
    expr.visit(visitor);
    //print(visitor.asString());
    expect(visitor.asString(), equals(expected));
  }
  
  final visitor = new StringExprVisitor();
}
