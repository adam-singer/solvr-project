// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Expression with one operand */
abstract class UnaryExpr extends Expr {
  UnaryExpr(Expr operandExpr, OperatorType operatorType)
    : token = operatorType.simpleName,
      type = operatorType
  {
    operand = operandExpr;
  }

  Expr get operand => _operand;

  set operand(Expr operand) {
    _operand = operand;
    operand.parent = this;
  }

  Expr map(ExprConverter converter) {
    operand = converter(operand);
    return this;
  }

  List<Expr> get operands => [ operand ];
  
  final String token;
  final IType type;
  Expr _operand;
}



