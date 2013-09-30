// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Operator expression with n operands */
abstract class NaryOperatorExpr extends Expr {
  NaryOperatorExpr(this.operands, this.type) {
    operands.forEach((Expr elm) => elm.parent = this);
  }

  Expr map(ExprConverter converter) {
    _mapElements(converter, operands, this);
    return this;
  }
  
  final List<Expr> operands;
  final IType type;
}


