// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a method invocation like [1,2].length() */
class MethodExpr extends Expr {
  MethodExpr(this.target, this.name, this.args);

  asString(StringBuffer buf) {
    target.asString(buf);
    buf.write(".$name");
    args.asString(buf);
  }

  Expr map(ExprConverter converter) {
    converter(target);
    target.parent = this;
    converter(args);
    args.parent = this;
    return this;
  }

  List<Expr> get operands => [ target, args ];

  Expr get clone => asMethod(target.clone, name, args.clone);

  final IType type = LanguageTypes.METHOD;
  final String name;
  ObjectExpr target;
  TupleExpr args;
}

MethodExpr asMethod(ObjectExpr target, String name, TupleExpr args) => new MethodExpr(target, name, args);
