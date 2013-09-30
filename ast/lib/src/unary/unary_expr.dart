// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

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

  @override
  Expr map(ExprConverter converter) {
    operand = converter(operand);
    return this;
  }

  @override
  List<Expr> get operands => [ operand ];

  @override
  final IType type;
  
  final String token;
  Expr _operand;
}




