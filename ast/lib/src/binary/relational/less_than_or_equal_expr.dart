// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** less than or equal 2 <= 2 */
class LessThanOrEqualExpr extends RelationalExpr {
  LessThanOrEqualExpr(Expr left, Expr right): super(left, right, BinaryOperators.LESS_OR_EQUAL);

  Expr get clone => lessThanOrEqual(left.clone, right.clone);
}

LessThanOrEqualExpr lessThanOrEqual(Expr e1, Expr e2) => new LessThanOrEqualExpr(e1, e2);
