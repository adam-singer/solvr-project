// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_analyzer_test;

class AnalyzerTest {
  AnalyzerTest() {
    // TODO predefine
    // f(x) -> String
    // g(x) -> Number

    group("analyze unary -", () {
      test("factorial expression", () {
        assertTypeError("Object!", description:"factorial of Object is undefined");
        assertTypeError("f(x)!", description:"factorial of function returning string is undefined");
        // TODO should factorial of list be factorial of each element ?
        assertTypeMatch("g(x)!", description:"factorial of function returning number is valid");
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

    typeChecker.analyze(expr);
  }

  assertTypeError(String expresssion, {String description: null}) {
    Parser parser = new SolvrParser(expresssion);
    Expr expr = parser.parse();

    typeChecker.analyze(expr);
  }

  final SolvrAnalyzer typeChecker = new SolvrAnalyzer();
}
