// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a truth value */
class BoolExpr extends NullaryExpr<bool> {
  BoolExpr(bool value): super(value, ObjectTypes.BOOL);

  Expr get clone => asBool(value);
}

BoolExpr asBool(bool boolean) => new BoolExpr(boolean);
