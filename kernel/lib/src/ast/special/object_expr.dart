// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a object declaration like class MyName {} */
abstract class ObjectExpr extends Expr {
  ObjectExpr(this.type);

  final IType type;
}

