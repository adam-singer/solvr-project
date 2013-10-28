// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Factorial fx. 3! */
class FactorialExpr extends UnaryExpr {
  FactorialExpr(Expr operand): super(operand, UnaryOperators.FACTORIAL);

  @override
  Expr get clone => factorial(operand.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitFactorialExpr(this);
}

FactorialExpr factorial(var expr) => new FactorialExpr(expr);
