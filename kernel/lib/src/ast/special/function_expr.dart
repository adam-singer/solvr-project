// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a function declaration like "f(x) = x^2" or "Number g(x) => x+x" */
class FunctionExpr extends Expr {
  FunctionExpr(this.name, this.args, this.body, [this.returnType = null]) {
    args.parent = this;
    body.parent = this;
    if(hasReturnType()) {
      returnType.parent = this;
    }
  }

  asString(StringBuffer buf) {
    if(hasReturnType()) {
      returnType.asString(buf);
    }
    buf.write(name);
    args.asString(buf);
    if(body is! BlockExpr) {
      buf.write(r" = ");
    }
    body.asString(buf);
  }

  Expr map(ExprConverter converter) {
    if(hasReturnType()) {
      args = converter(returnType);
      returnType.parent = this;
    }
    args = converter(args);
    args.parent = this;
    body = converter(body);
    body.parent = this;
    return this;
  }

  bool hasReturnType() => returnType != null;

  List<Expr> get operands => [ args, body ];

  Expr get clone => asFunction(name, args.clone, body.clone);

  final IType type = LanguageTypes.FUNCTION;
  final String name;
  TupleExpr args;
  Expr body, returnType;
}

FunctionExpr asFunction(String name, TupleExpr args, Expr body) => new FunctionExpr(name, args, body);
