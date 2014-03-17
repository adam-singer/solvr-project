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
  }
  
  assertTypeCheck(String expresssion) {
    Parser parser = new SolvrParser(expresssion);
    Expr expr = parser.parse();
    
    var typeChecker = new TypeChecker();
    typeChecker.check(expr);
  }
}
