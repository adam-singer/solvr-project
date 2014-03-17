// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents an anonymous function like (x) => x^2 */
class AnonymousFunctionExpr extends SpecialExpr {
  AnonymousFunctionExpr(this.args, this.body) {
    args.parent = this;
    body.parent = this;
  }

  @override
  Expr map(ExprConverter converter) {
    args = converter(args);
    args.parent = this;
    body = converter(body);
    body.parent = this;
    return this;
  }

  @override
  List<Expr> get operands => [ args, body ];

  @override
  Expr get clone => asAnonymousFunction(args.clone, body.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitAnonymousFunctionExpr(this);

  final IType type = LanguageTypes.ANONYMOUS_FUNCTION;
  Expr args;
  Expr body;
}

AnonymousFunctionExpr asAnonymousFunction(TupleExpr args, Expr body) {
  return new AnonymousFunctionExpr(args, body);
}
