// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Lambda calculus style substitution of free variable in expression fx: x := y+2 */
class SubstitutionExpr extends SimpleBinaryExpr {
  SubstitutionExpr(Expr left, Expr right): super(left, right, BinaryOperators.SUBSTITUTION);

  @override
  Expr get clone => substitution(left.clone, right.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitSubsitutionExpr(this);
}

SubstitutionExpr substitution(Expr e1, Expr e2) => new SubstitutionExpr(e1, e2);
