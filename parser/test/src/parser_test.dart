// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_parser_test;

class ParserTest {
  ParserTest() {
    group("parsing nullary -", () {   
      test("symbol expression", () {
        assertExpression("x", Matchers.isSymbol);
        assertExpression("pi", Matchers.isSymbol);
        assertExpression("e", Matchers.isSymbol);
      });
      
      test("numbers expression", () {
        assertExpression("2", Matchers.isNumber);
        assertExpression(".2", Matchers.isNumber, "0.2");
        assertExpression("1.2", Matchers.isNumber);
        assertExpression("1.000", Matchers.isNumber, "1");
      });
      
      test("string expression", () {
        assertExpression(r'""', Matchers.isString);
        assertExpression(r'"word"', Matchers.isString);
        assertExpression(r'"more words"', Matchers.isString);
      });
    }); 
     
    group("parsing unary -", () {  
      test("factorial expression", () {
        assertExpression("x!", Matchers.isFactorial);
        assertExpression("2!", Matchers.isFactorial);
      });
      
      test("negative expression", () {
        assertExpression("-x", Matchers.isNegative);
        assertExpression("-1.2", Matchers.isNegative);
      });
    }); 
    
    group("parsing binary -", () { 
      test("difference expressions", () {
        assertExpression("3x - 2x", Matchers.isDifference, "3 * x - 2 * x");
        assertExpression("4x! - x!", Matchers.isDifference, "4 * x! - x!");
      });
      
      test("entry expressions", () {
        assertExpression("x:2", Matchers.isEntry);
        assertExpression("x:(2+3)", Matchers.isEntry, "x:(2 + 3)");
        assertExpression("color:blue", Matchers.isEntry);
      });
      
      test("fraction expressions", () {
        assertExpression("1/2", Matchers.isFraction);
        assertExpression("x/x", Matchers.isFraction);
      });
      
      test("guard expressions", () {
        assertExpression("x in 0..5 | x^2", Matchers.isGuard);
        assertExpression("Number | Symbol", Matchers.isGuard);
      });
      
      test("instance expressions", () {
        assertExpression("x is Symbol", Matchers.isInstanceOf);
        assertExpression("x is! Number", Matchers.isNotInstanceOf);
      });
      
      test("logical expressions", () {
        assertExpression("true && false", Matchers.isAnd);
        assertExpression("true || false", Matchers.isOr);
      });
      
      test("pow expressions", () {
        assertExpression("x^2", Matchers.isPower);
        assertExpression("x^3!", Matchers.isPower);
      });
      
      test("product expressions", () {
        assertExpression("-1 * x * -1 * x^-1", Matchers.isProduct, "-x * -1 * x^-1");
        assertExpression("x*(1 + y)", Matchers.isProduct, "x * (1 + y)");
        assertExpression("(1+x)(1+y)", Matchers.isProduct, "(1 + x) * (1 + y)");
        assertExpression("f(x)(1+y)", Matchers.isProduct, "f(x) * (1 + y)");
        assertExpression("x*(x + y + z + 1)", Matchers.isProduct, "x * (x + y + z + 1)");
        assertExpression("-3^2(-3 + 6)", Matchers.isProduct, "-3^2 * (-3 + 6)");
        assertExpression("(2 + 4)! * (-3 + 5)", Matchers.isProduct);
      });
      
      test("relational expressions", () {
        assertExpression("1 < 2", Matchers.isLessThan);
        assertExpression("1 < x < 10", Matchers.isAnd, "1 < x && x < 10");
        assertExpression("1 < a > 10 < b", Matchers.isAnd, "1 < a && a > 10 && 10 < b");
      });
      
      test("substitution expressions", () {
        assertExpression("x := 2", Matchers.isSubstitution);
        assertExpression("x := (y + 3)", Matchers.isSubstitution);
      });
      
      test("sum expressions", () {
        assertExpression("x + y", Matchers.isSum);
        assertExpression("f(x) + f(x)", Matchers.isSum);
        assertExpression("3 * x! + x!", Matchers.isSum);
        assertExpression("x^2 + 2", Matchers.isSum);
        assertExpression("2 + x * 2 + x", Matchers.isSum); // x + 2x + 2
      });
    });   
      
    group("parsing nary -", () {  
      test("dictionary expressions", () {
        assertExpression("{x:2}", Matchers.isDictionary);
        assertExpression("{x:2,y:4}", Matchers.isDictionary);
      });
      
      test("interval expressions", () {
        assertExpression("1..10", Matchers.isInterval);
        assertExpression("1..0.1..20", Matchers.isInterval);
        assertExpression("1..1..30", Matchers.isInterval);
        assertExpression("1..-1..-40", Matchers.isInterval);
      });
      
      test("list expressions", () {
        assertExpression("[]", Matchers.isList);
        assertExpression("[[]]", Matchers.isList);
        assertExpression("[1]", Matchers.isList);
        assertExpression("[1,2]", Matchers.isList);
        assertExpression("[[1;2]]", Matchers.isList);
        assertExpression("[[1;2],[3;4;5]]", Matchers.isList);
      });
      
      test("matrix expressions", () {
        assertExpression("[[1;2];[3;4]]", Matchers.isMatrix);
        assertExpression("[[1;2;3];[4;5;6]]", Matchers.isMatrix);
      });
      
      test("set expressions", () {
        assertExpression("{}", Matchers.isSet);
        assertExpression("{1,2}", Matchers.isSet);
      });
      
      test("tuple expressions", () {
        assertExpression("()", Matchers.isTuple);
        assertExpression("(())", Matchers.isTuple);
        assertExpression("(1)", Matchers.isTuple);
        assertExpression("(1,2)", Matchers.isTuple);
        assertExpression("((1,2),(3,4,5))", Matchers.isTuple);
      });
      
      test("vector expressions", () {
        assertExpression("[1;2]", Matchers.isVector);
        assertExpression("[1;2;3]", Matchers.isVector);
        assertExpression("[x;x^2]", Matchers.isVector);
        assertExpression("[f(x);g(x);h(x)]", Matchers.isVector);
        assertExpression("[x;(1 + x);x + 2;(1 + x)^2]", Matchers.isVector);
      });
    });
      
    group("parsing special -", () { 
      test("anonymous function expressions", () {
        assertExpression("(x,y) => x^y", Matchers.isAnonymousFunction);
        assertExpression("(x) => sqrt(x)", Matchers.isAnonymousFunction);
      });
      
      test("assignment expressions", () {
        assertExpression("x = 2", Matchers.isAssign);
      });
      
      test("dot expressions", () {
        assertExpression("[a;b].[c;d]", Matchers.isDot);
        assertExpression("[[a;b];[c;d]].[[a;b];[c;d]]", Matchers.isDot);
        assertExpression("[1,2].get(1)", Matchers.isDot); 
        assertExpression("[1;2].get(1)", Matchers.isDot); 
        assertExpression("{x:2,y:4}.get(y)", Matchers.isDot); 
        assertExpression("[[1,2],[3,4]].get(1)", Matchers.isDot); 
      });
      
      test("function expressions", () {
        assertExpression("f(x) = x^2", Matchers.isFunction);
      });
      
      test("infix function expressions", () {
        assertExpression("x in 1..10", Matchers.isBind);
        assertExpression("{b} subset {b,c,d}", Matchers.isSubset);  
        assertExpression("{a,b,c} !subset {b,c,d}", Matchers.isNotSubset);  
        assertExpression("{a,b} union {b,c}", Matchers.isUnion);           
        assertExpression("{a,b} intersect {b,c}", Matchers.isIntersect);   
        assertExpression(r"{a,b} \ {b,c}", Matchers.isComplement);
      });
      
      test("prefix function expressions", () {
        assertExpression("hold(2 + 2)", Matchers.isInvoke);
        assertExpression("gcd(2,3)", Matchers.isInvoke);
        assertExpression("plot(x^2,-10,10)", Matchers.isInvoke);
        assertExpression("listPlot([[1,1],[2,2]],{color:blue})", Matchers.isInvoke);
        assertExpression("f(x)", Matchers.isInvoke);
        assertExpression("g(x,y)", Matchers.isInvoke);
      });
      
      test("typed expressions", () {
        assertExpression("Number n", Matchers.isTyped);
        assertExpression("f(Symbol x) = x^2", Matchers.isFunction);
        assertExpression("List f(Symbol x) = [x^2]", Matchers.isTyped);
      });
      
      test("sequence expressions", () {
        assertExpression("{x in 0..5 | x^2}", Matchers.isSeq);
        assertExpression("{x in 1..5, y in 1..y | x^y}", Matchers.isSeq);
      });
    });  
    
    
    group("parsing multiline expressions -", () {
      test("if statement", () {
        assertStatement(r'''
          if(true) {
            print("hello")
          }
        ''', Matchers.isConditional);
      });
      
      test("if/else statement", () {
        assertStatement(r'''
          if(true) {
            print("yes")
          } else {
            print("no")
          }
        ''', Matchers.isConditional);
      });
      
      test("if/else-if statement", () {
        assertStatement(r'''
          if(true) {
            print("yes")
          } else if(false) {
            print("no")
          }
        ''', Matchers.isConditional);
      });
      
      test("if/else-if/else statement", () {
        assertStatement(r'''
          if(x==1) {
            print("1")
          } else if(x==4) {
            print("4")
          } else {
            print(x)
          }
        ''', Matchers.isConditional);
      });
      
      test("simple function declaration", () {
        assertStatement(r'''
          f(x) {
            x = x+1
            y = x+z
          } 
        ''', Matchers.isFunction);
      });
      
      test("complex function declaration", () {
        assertStatement(r'''
          Number doStuff(List a) {
            Number res
            if(a is List) {
              res = a.length()
            } else if(a is Number) {
              res = a
            }
            return res
          }
        ''', Matchers.isTyped);
      });
      
      /*
      """
        match a { 
          as List   | (List l)   => l.length > 1   
          as Number | (Number n) => n > 1
        }

        match s { 
          as "123"    | (String s)   => l.length > 1   
          as ~= "a.*" | (String s) => n > 1
        }
      """
        */
    }); 
  } 

  assertExpression(String expression, ExprMatcher matcher, [ String compareTo = null ]) {
    var parser = new SolvrParser(expression);
    parser.registerObjectTypes(["List", "String", "Set", "Number", "Bool", "Symbol"]);
    var expr = parser.parse();

    // check that expression parsed as expected
    var expectedOutput = (compareTo == null) ? expression : compareTo;
    expect(matcher(expr), isTrue, reason:"type comparison failes on instance $expr");
    expect(expr.toString(), equals(expectedOutput), reason:"string comparison of $expectedOutput to ${expr.toString()} fails");
    
    // check that expression deep cloning works
    var clone = expr.clone;
    expect(identical(clone,expr), isFalse);
    expect(expectedOutput, equals(clone.toString()));
    
    // check parent/child structure is correct
    expect(expr.parent, isNull, reason:"expected parent to be null, got ${expr.parent}");
    if(Matchers.isBinary(expr)) {
      expect(identical(expr.left.parent, expr), isTrue);
      expect(identical(expr.right.parent, expr), isTrue);
    } else if(Matchers.isUnary(expr)) {
      expect(identical(expr.operand.parent, expr), isTrue);
    } 
  }
  
  assertStatement(String expression, ExprMatcher matcher) {
    var parser = new SolvrParser(expression);
    parser.registerObjectTypes(["List", "String", "Set", "Number", "Bool", "Symbol"]);
    var expr = parser.parse();
    
    expect(matcher(expr), isTrue, reason:"type comparison failes on instance $expr");
    // compare output, ignoring whitespace
    var output = expr.toString();
    int j=0;
    for(int i=0; i<expression.length; i++) {
      String expected = expression[i];
      if(expected != "\n" && expected != " ") {
        String actual = output[j];
        while(actual == "\n" || actual == " ") {
          j++;
          actual = output[j];
        }
        expect(expected, equals(actual), reason:"string comparison of $expression to $output fails");
        
        j++;
      }
    }
  }
}



