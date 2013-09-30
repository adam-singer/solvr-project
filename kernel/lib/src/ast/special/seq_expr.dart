// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a sequence expression such as {x in 1..10 | (x) => x^2} */
class SeqExpr extends Expr {
  SeqExpr(this.args, this.body) {
    args.map((Expr arg) => arg.parent = this);
    body.parent = this;
  }

  asString(StringBuffer buf) {
    buf.write(r"{");
    _renderElements("", r", ", "", buf, args);
    buf.write(r" | ");
    body.asString(buf);
    buf.write(r"}");
  }

  Expr map(ExprConverter converter) {
    _mapElements(converter, operands, this);
    return this;
  }

  List<Expr> get operands => [ args, body ];

  Expr get clone => asSeq(_cloneExprList(args), body.clone);

  final IType type = LanguageTypes.SEQUENCE;
  List<Expr> args;
  Expr body;
}

SeqExpr asSeq(List<Expr> args, Expr body) => new SeqExpr(args, body);
