// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a function call like f(x) */
class InvokeExpr extends Expr {
  InvokeExpr(this.name, this.args);

  @override
  asString(StringBuffer buf) {
    buf.write(name);
    args.asString(buf);
  }

  @override
  Expr map(ExprConverter converter) {
    converter(args);
    args.parent = this;
    return this;
  }

  @override
  List<Expr> get operands => args.operands;

  @override
  Expr get clone => asInvoke(name, args.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitInvokeExpr(this);

  @override
  final IType type = LanguageTypes.INVOKE;
  
  final String name;
  TupleExpr args;
}

InvokeExpr asInvoke(String name, var args) {
  if(args is! TupleExpr) {
    args = asTuple(args);
  }
  return new InvokeExpr(name, args);
}
