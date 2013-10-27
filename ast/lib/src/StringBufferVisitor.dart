// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Visitor that visits node and stores its content in a string buffer */
class StringBufferVisitor implements ExprVisitor {
  // binary 
  
  // nary
  
  // nullary
  visitBoolExpr(BoolExpr expr) => _visitNullaryExpr(expr);
  
  visitNumberExpr(NumberExpr expr) => _visitNullaryExpr(expr);
  
  visitStringExpr(StringExpr expr) => _visitNullaryExpr(expr);
  
  visitSymbolExpr(SymbolExpr expr) => _visitNullaryExpr(expr);
  
  _visitNullaryExpr(NullaryExpr expr) => _buf.write(expr.value);
  
  // special
  
  // unary
  
  String asString() => _buf.toString();
  
  clear() => _buf.clear();
  
  final StringBuffer _buf = new StringBuffer();
}