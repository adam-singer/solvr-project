// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

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
