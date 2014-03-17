// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

// TODO can we kill this for the first release ?

/** Generic fx Set<Symbol> */
class GenericExpr extends SpecialExpr {
  GenericExpr(this.template, this.operands);

  @override
  Expr map(ExprConverter converter) {
    converter(template);
    template.parent = this;
    _mapElements(converter, operands, this);
    return this;
  }

  @override
  Expr get clone => asGeneric(template.clone, _cloneExprList(operands));
  
  @override
  visit(ExprVisitor visitor) => visitor.visitGenericExpr(this);

  @override
  final IType type = LanguageTypes.GENERIC;
  
  SymbolExpr template;
  List<Expr> operands;
}

GenericExpr asGeneric(SymbolExpr template, List<Expr> boundaries) => new GenericExpr(template, boundaries);
