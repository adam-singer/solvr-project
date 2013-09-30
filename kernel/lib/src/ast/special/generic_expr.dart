// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

// TODO can we kill this for the first release ?

/** Generic fx Set<Symbol> */
class GenericExpr extends Expr {
  GenericExpr(this.template, this.operands);

  asString(StringBuffer buf) {
    template.asString(buf);
    _renderElements("<", r"|", ">", buf, operands);
  }

  Expr map(ExprConverter converter) {
    converter(template);
    template.parent = this;
    _mapElements(converter, operands, this);
    return this;
  }

  Expr get clone => asGeneric(template.clone, _cloneExprList(operands));

  final IType type = LanguageTypes.GENERIC;
  SymbolExpr template;
  List<Expr> operands;
}

GenericExpr asGeneric(SymbolExpr template, List<Expr> boundaries) => new GenericExpr(template, boundaries);
