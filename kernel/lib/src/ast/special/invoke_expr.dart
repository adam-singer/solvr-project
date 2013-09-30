// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a function call like f(x) */
class InvokeExpr extends Expr {
  InvokeExpr(this.name, this.args);

  asString(StringBuffer buf) {
    buf.write(name);
    args.asString(buf);
  }

  Expr map(ExprConverter converter) {
    converter(args);
    args.parent = this;
    return this;
  }

  List<Expr> get operands => args.operands;

  Expr get clone => asInvoke(name, args.clone);

  final IType type = LanguageTypes.INVOKE;
  final String name;
  TupleExpr args;
}

InvokeExpr asInvoke(String name, var args) {
  if(args is! TupleExpr) {
    args = tupleOf(args);
  }
  return new InvokeExpr(name, args);
}