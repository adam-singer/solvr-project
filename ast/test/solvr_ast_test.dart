// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_ast_test;

import 'package:unittest/unittest.dart';
import 'package:solvr_ast/solvr_ast.dart';

main() {
  
}

class VisitorTest {
  VisitorTest() {
    final visitor = new StringBufferVisitor();
    
    before() {
      visitor.clear();
    }
    
    test("visit binary expr", () {
      var number1 = Expr.number(null,"1");
      var number2 = Expr.number(null,"2");
      var sumExpr = Expr.sum(null,number1, number2);
     
      sumExpr.visit(visitor);
      expect(visitor.asString, equals("1 + 2"));  
    });
  }
}

