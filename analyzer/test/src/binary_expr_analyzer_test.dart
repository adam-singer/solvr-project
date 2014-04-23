// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_analyzer_test;

class BinaryExprAnalyzerTest extends AnalyzerTest {
  BinaryExprAnalyzerTest() {
    group("analyze binary -", () {
      test("dot expression", () {
        // TODO is this a type check ? 
        // case: fn().gn() here fn() and gn() must resolve to a vector/matrix
        // case: fn().y here fn() and y must resolve to a vector/matrix
        // case: x.y here x and y must resolve to vector/matrix
      });
      
      test("algebraic collections expressions", () {
        assertTypeMatch("[1,2]*[1,2]");
        assertTypeError("[1,2,3]*[1,2]", description:"only equal length algebraic collections can be combined"); 
      });
      
      test("relational expressions", () {
        
      });
      
      test("set expressions", () {
        
      });
    });
  }
}