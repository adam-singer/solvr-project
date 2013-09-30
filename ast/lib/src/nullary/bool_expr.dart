// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Represents a truth value */
class BoolExpr extends NullaryExpr<bool> {
  BoolExpr(bool value): super(value, ObjectTypes.BOOL);

  @override
  Expr get clone => asBool(value);
  
  @override
  visit(ExprVisitor visitor) => visitor.visitBoolExpr(this);
}

BoolExpr asBool(bool boolean) => new BoolExpr(boolean);
