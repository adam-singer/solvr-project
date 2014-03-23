// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_typechecker_test;

class TypeCheckerTest {
  TypeCheckerTest() {
    group("type checker", () {
      test("token matching", () {

      });
    });

    // TODO predefine
    // f(x) -> String
    // g(x) -> Number

    group("type checking unary -", () {
      test("factorial expression", () {
        assertTypeError("Object!", description:"factorial of Object is undefined");
        assertTypeError("f(x)", description:"factorial of function returning string is undefined");
        // TODO should factorial of list be factorial of each element ?
        assertTypeMatch("g(x)", description:"factorial of function returning number is valid");
      });

      test("negative expression", () {
        assertTypeError("-Object", description:"nagation of Object is undefined");
        assertTypeError("-f(x)", description:"negation of function returning String is undefined");
        assertTypeMatch("-g(x)", description:"negation of function returning number is valid");
      });
    });
  }

  assertTypeMatch(String expresssion, {String description: null}) {
    Parser parser = new SolvrParser(expresssion);
    Expr expr = parser.parse();

    typeChecker.check(expr);
  }

  assertTypeError(String expresssion, {String description: null}) {
    Parser parser = new SolvrParser(expresssion);
    Expr expr = parser.parse();

    typeChecker.check(expr);
  }

  final TypeChecker typeChecker = new TypeChecker();
}
