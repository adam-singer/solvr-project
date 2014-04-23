// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a function call like f(x) */
@LanguageType("Invoke", AreaTypes.BUILT_IN)
class InvokeExpr extends SpecialExpr {
  InvokeExpr(this.name, this.args);

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
  
  final String name;
  TupleExpr args;
}

InvokeExpr asInvoke(String name, var args) {
  if(args is! TupleExpr) {
    args = asTuple(args);
  }
  return new InvokeExpr(name, args);
}
