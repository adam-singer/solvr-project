// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Expression with no operands (a literal) */
abstract class NullaryExpr<T> extends ObjectExpr {
  NullaryExpr(this.value, IType type): super(type);

  @override
  Expr map(ExprConverter converter) {
    throw new UnsupportedError("nullary expressions has no operands");
  }

  @override
  List<Expr> get operands {
    throw new UnsupportedError("nullary expressions has no operands");
  }
  
  final T value;
}


