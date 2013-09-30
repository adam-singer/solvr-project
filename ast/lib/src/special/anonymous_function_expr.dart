// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents an anonymous function like (x) => x^2 */
class AnonymousFunctionExpr extends Expr {
  AnonymousFunctionExpr(this.args, this.body) {
    args.parent = this;
    body.parent = this;
  }

  asString(StringBuffer buf) {
    args.asString(buf);
    buf.write(r" => ") ;
    body.asString(buf);
  }

  Expr map(ExprConverter converter) {
    args = converter(args);
    args.parent = this;
    body = converter(body);
    body.parent = this;
    return this;
  }

  List<Expr> get operands => [ args, body ];

  Expr get clone => asAnonymousFunction(args.clone, body.clone);

  final IType type = LanguageTypes.ANONYMOUS_FUNCTION;
  TupleExpr args;
  Expr body;
}

AnonymousFunctionExpr asAnonymousFunction(TupleExpr args, Expr body) {
  if(!args.every((e) => e is SymbolExpr)) {
    throw new ArgumentError("parameters for anonymous functions can only be symbols");
  }
  return new AnonymousFunctionExpr(args, body);
}
