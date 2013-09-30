// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a variable assignment like x = 2 or x = y + 3 */
class AssignExpr extends Expr {
  AssignExpr(this.variable, this.value) {
    variable.parent = this;
    value.parent = this;
  }

  asString(StringBuffer buf) {
    variable.asString(buf);
    buf.write(r" = ");
    value.asString(buf);
  }

  Expr map(ExprConverter converter) {
    // Note: the left hand side variable is not visited by the converter as
    // it can/must not be simplified (fx. looked up and replaced)
    value = converter(value);
    value.parent = this;
    return this;
  }

  List<Expr> get operands => [ value ];

  Expr get clone => asAssign(variable.clone, value.clone);

  final IType type = LanguageTypes.ASSIGN;
  SymbolExpr variable;
  Expr value;
}

AssignExpr asAssign(SymbolExpr variable, Expr value) => new AssignExpr(variable, value);
