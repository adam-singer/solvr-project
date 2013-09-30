// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** N-ary expressions that represents a operator */
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


