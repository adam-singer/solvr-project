// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast_test;

class StringExprVisitorTest {
  StringExprVisitorTest() {
    group("binary expressions -", () {
      test("complex number", () {
        assertExpression(asComplexNumber(asInteger(3), asInteger(4)), "3 + i4");
      });
      
      test("difference", () {
        assertExpression(asDifference(asInteger(3), asInteger(2)), "3 - 2");
      });
      
      test("dot product", () {
        var vec1 = asVector([asInteger(1), asInteger(2)]);
        var vec2 = asVector([asInteger(3), asInteger(4)]);
        assertExpression(asDot(vec1, vec2), "[1;2].[3;4]");
      });
      
      test("fraction",() {
        assertExpression(asFraction(asSymbol("a"), asSymbol("b")), "a/b");
      });
      
      test("power",() {
        assertExpression(asPower(asSymbol("a"), asInteger(3)), "a^3");
      });
      
      test("and",() {
        assertExpression(asAnd(asBool(true), asBool(false)), "true && false");
      });
      
      test("or",() {
        assertExpression(asOr(asBool(true), asBool(false)), "true || false");
      });
      
      test("bind", (){
        var interval = asInterval(asInteger(1), asNothing(), asInteger(10));
        assertExpression(asBind(asSymbol("x"), interval), "x in 1..10");
      });
      
      test("guard", (){
        assertExpression(asGuard(asSymbol("a"), asSymbol("b")), "a | b");
      });
      
      test("instance of", (){
        assertExpression(asInstanceOf(asSymbol("a"), asSymbol("Vector")), "a is Vector");
      });
      
      test("not instance of", (){
        assertExpression(asNotInstanceOf(asSymbol("a"), asSymbol("Vector")), "a is! Vector");
      });
      
      test("substitution", (){
        assertExpression(asSubstitution(asSymbol("x"), asSymbol("y") + asInteger(2)), "x := y + 2");
      });
      
      test("equal", () {
        assertExpression(asEqual(asInteger(2), asInteger(2)), "2 == 2");
      });
      
      test("greater than", () {
        assertExpression(asGreaterThan(asInteger(3), asInteger(2)), "3 > 2");
      });
      
      test("greater than or equal", () {
        assertExpression(asGreaterThanOrEqual(asInteger(3), asInteger(2)), "3 >= 2");
      });
      
      test("less than", () {
        assertExpression(asLessThan(asInteger(2), asInteger(3)), "2 < 3");
      });
      
      test("less than or equal", () {
        assertExpression(asLessThanOrEqual(asInteger(2), asInteger(2)), "2 <= 2");
      });
      
      test("not equal", () {
        assertExpression(asNotEqual(asInteger(3), asInteger(4)), "3 != 4");
      });
      
      var set0 = asSet([asInteger(3)]);
      var set1 = asSet([asInteger(1), asInteger(2), asInteger(3)]);
      var set2 = asSet([asInteger(3), asInteger(4), asInteger(5)]);
      test("complement", () {
        assertExpression(asComplement(set1, set2), r"{1,2,3} \ {3,4,5}");
      });
      
      test("entry", () {
        assertExpression(asEntry(asSymbol("product"), asSymbol("solvr")), "product:solvr");
      });
      
      test("intersect", () {
        assertExpression(asIntersect(set1, set2), "{1,2,3} intersect {3,4,5}");
      });
      
      test("not subset", () {
        assertExpression(asNotSubset(set0, set1), "{3} !subset {1,2,3}");
      });
      
      test("subset", () {
        assertExpression(asSubset(set0, set1), "{3} subset {1,2,3}");
      });
      
      test("union", () {
        assertExpression(asUnion(set1, set2), "{1,2,3} union {3,4,5}");
      });
    });
    
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
        assertExpression(asMatrix([vec1, vec2]), "[[1;2];[3;4]]");
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
        assertExpression(asDictionary([asEntry(asString("key1"), asString("val1"))]), '{\"key1\":\"val1\"}'); 
        assertExpression(asDictionary([asEntry(asString("key1"), asString("val1")),
                                       asEntry(asString("key2"), asString("val2"))]), '{\"key1\":\"val1\",\"key2\":\"val2\"}');
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
        assertExpression(asString(""), '\"\"');
        assertExpression(asString("hello"), '\"hello\"');
        assertExpression(asString("hello world"), '\"hello world\"');
      });
      
      test("symbol", () {
        assertExpression(asSymbol("x"), "x");
      });
    });
    
    group("special expressions -", () {
      test("anonymous function", (){
        var anon1 = asAnonymousFunction(asTuple([]), asSymbol("a") * asSymbol("b"));
        assertExpression(anon1, "() => a * b");
        
        var anon2 = asAnonymousFunction(asTuple(asSymbol("a")), asSymbol("2") * asSymbol("a"));
        assertExpression(anon2, "(a) => 2 * a");
        
        var anon3 = asAnonymousFunction(asTuple([asSymbol("a"),asSymbol("b")]), asProduct([asSymbol("2"),asSymbol("a"),asSymbol("b")]));
        assertExpression(anon3, "(a,b) => 2 * a * b");
      });
      
      test("assign", () {
        var assign1 = asAssign(asSymbol("x"), asInteger(2));
        assertExpression(assign1, "x = 2");
        
        var assign2 = asAssign(asSymbol("x"), asSymbol("y") + asInteger(3));
        assertExpression(assign2, "x = y + 3");
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
    //print(visitor.toString());
    expect(visitor.toString(), equals(expected));
  }
  
  final visitor = new StringExprVisitor();
}
