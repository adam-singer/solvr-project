// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Difference fx. 3-2 */
class DifferenceExpr extends SimpleBinaryExpr {
  DifferenceExpr(Expr left, Expr right): super(left, right, BinaryOperators.DIFFERENCE);

  Expr get clone => left.clone - right.clone;
}



