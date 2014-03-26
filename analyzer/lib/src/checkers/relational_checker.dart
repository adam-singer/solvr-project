// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_analyzer_internal;

class RelationalChecker extends Checker {
  RelationalChecker(this.typeChecker, this.registry);

  check(var expr) {
    if(!expr.anyOf([isEqual, isNotEqual])) {
      expr.operands.forEach((Expr operand) {
        // TODO infer operand (i.e. handle functions)
        if(!isAlgebraic(operand)) {
          error("relational operator ${expr.token} cannot be applied to operand ${operand}");
        }
      });
    }
  }
  
  final TypeChecker typeChecker;
  final Registry registry;
}
