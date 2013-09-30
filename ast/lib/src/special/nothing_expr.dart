// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

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
