// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Expression with no operands (a literal) */
abstract class NullaryExpr<T> extends ObjectExpr {
  NullaryExpr(this.value, IType type): super(type);

  Expr map(ExprConverter converter) {
    throw new UnsupportedError("nullary expressions has no operands");
  }

  asString(StringBuffer buf) {
    buf.write(value);
  }

  List<Expr> get operands {
    throw new UnsupportedError("nullary expressions has no operands");
  }
  
  final T value;
}


