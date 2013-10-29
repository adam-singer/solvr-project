// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_checker;

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
