// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** greater than or equal fx. 3 >= 2 */
class GreaterThanOrEqualExpr extends RelationalExpr {
  GreaterThanOrEqualExpr(Expr left, Expr right): super(left, right, BinaryOperators.GREATER_OR_EQUAL);

  Expr get clone => greaterThanOrEqual(left.clone, right.clone);
}

GreaterThanOrEqualExpr greaterThanOrEqual(Expr e1, Expr e2) => new GreaterThanOrEqualExpr(e1, e2);