// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a function declaration like "f(x) = x^2" or "Number g(x) => x+x" */
class FunctionExpr extends Expr {
  FunctionExpr(this.name, this.args, this.body, [this.returnType = null]) {
    args.parent = this;
    body.parent = this;
    if(hasReturnType()) {
      returnType.parent = this;
    }
  }

  @override
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

  @override
  List<Expr> get operands => [ args, body ];

  @override
  Expr get clone => asFunction(name, args.clone, body.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitFunctionExpr(this);

  @override
  final IType type = LanguageTypes.FUNCTION;
  
  final String name;
  TupleExpr args;
  Expr body, returnType;
}

FunctionExpr asFunction(String name, TupleExpr args, Expr body) => new FunctionExpr(name, args, body);
