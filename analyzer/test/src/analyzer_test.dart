// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_analyzer_test;

abstract class AnalyzerTest {
  assertTypeMatch(String expresssion, {String description: null}) {
    Parser parser = new SolvrParser(expresssion);
    Expr expr = parser.parse();

    _typeChecker.analyze(expr);
  }

  assertTypeError(String expresssion, {String description: null}) {
    Parser parser = new SolvrParser(expresssion);
    Expr expr = parser.parse();

    _typeChecker.analyze(expr);
  }

  final SolvrAnalyzer _typeChecker = new SolvrAnalyzer();
}
