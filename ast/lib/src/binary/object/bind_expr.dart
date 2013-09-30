// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Binding fx: x in 1..10 */
class BindExpr extends SimpleBinaryExpr {
  BindExpr(Expr left, Expr right): super(left, right, BinaryOperators.BIND);

  Expr get clone => bind(left.clone, right.clone);
}

BindExpr bind(Expr e1, Expr e2) => new BindExpr(e1, e2);
