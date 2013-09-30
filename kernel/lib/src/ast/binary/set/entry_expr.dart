// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a key value pair fx: product:solvr */
class EntryExpr extends SimpleBinaryExpr {
  EntryExpr(Expr left, Expr right): super(left, right, BinaryOperators.ENTRY, "");

  int get hashCode => left.toString().hashCode;

  Expr get clone => entry(left.clone, right.clone);
}

EntryExpr entry(Expr e1, Expr e2) => new EntryExpr(e1, e2);
