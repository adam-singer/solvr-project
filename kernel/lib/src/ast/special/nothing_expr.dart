// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Helper expression used to simplify checking for null values */
class NothingExpr extends ObjectExpr {
  NothingExpr(): super(LanguageTypes.NOTHING);

  Expr map(ExprConverter converter) => this;

  asString(StringBuffer buf) {
  }

  asMathString(StringBuffer buf) {
  }

  Expr get clone => asNothing();

  List<Expr> get operands => [];
}

NothingExpr asNothing() => new NothingExpr();
