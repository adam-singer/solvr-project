// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a variable assignment like x = 2 or x = y + 3 */
@LanguageType("Assign", AreaTypes.BUILT_IN)
class AssignExpr extends SpecialExpr {
  AssignExpr(this.variable, this.value) {
    variable.parent = this;
    value.parent = this;
  }

  @override
  Expr map(ExprConverter converter) {
    // Note: the left hand side variable is not visited by the converter as
    // it can/must not be simplified (fx. looked up and replaced)
    value = converter(value);
    value.parent = this;
    return this;
  }

  @override
  List<Expr> get operands => [ value ];

  @override
  Expr get clone => asAssign(variable.clone, value.clone);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitAssignExpr(this);
  
  SymbolExpr variable;
  Expr value;
}

AssignExpr asAssign(SymbolExpr variable, Expr value) => new AssignExpr(variable, value);
