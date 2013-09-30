// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a key value pair fx: product:solvr */
class EntryExpr extends SimpleBinaryExpr {
  EntryExpr(Expr left, Expr right): super(left, right, BinaryOperators.ENTRY, "");

  int get hashCode => left.toString().hashCode;

  Expr get clone => entry(left.clone, right.clone);
}

EntryExpr entry(Expr e1, Expr e2) => new EntryExpr(e1, e2);
