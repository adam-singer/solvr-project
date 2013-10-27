// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Visitor that visits node and stores its content in a string buffer */
class StringExprVisitor extends Object with 
  StringBinaryExprVisitor,
  StringNaryExprVisitor, 
  StringNullaryExprVisitor, 
  StringSpecialExprVisitor,
  StringUnaryExprVisitor implements ExprVisitor {
  
  ExprVisitor get visitor => this;
  
  String asString() => buf.toString();
  
  clear() => buf.clear();
  
  final StringBuffer buf = new StringBuffer();
}

abstract class StringBinaryExprVisitor implements BinaryExprVisitor {
  
}

abstract class StringNaryExprVisitor implements NaryExprVisitor {
  // algebraic nary operator expr
  visitProductExpr(ProductExpr expr) {
    if(expr.operands[0].toString() == "-1") {
      // -1 * x * y * .. = -x * y * ...
      buf.write(r"-");
      _renderElements("", r" * ", "", buf, tail(expr.operands));
    } else {
      _renderElements("", r" * ", "", buf, expr.operands);
    }
  }
  
  visitSumExpr(SumExpr expr) => _renderElements("", r" + ", "", buf, expr.operands);
  
  // algebraic nary expr
  visitListExpr(ListExpr expr) {
    _renderElements(r"[", r",", r"]", buf, expr.operands);
  }
  
  visitMatrixExpr(MatrixExpr expr) {
    buf.write(r"[");
    mapI(expr.operands, (Expr row, int i) {
      row.asString(buf);
      if(i < expr.operands.length - 1) buf.write(r";");
    });
    buf.write(r"]");
  }
  
  visitSetExpr(SetExpr expr) {
    _renderElements(r"{", r",", r"}", buf, expr.operands);
  }
  
  visitTupleExpr(TupleExpr expr) {
    _renderElements(r"(", r",", r")", buf, expr.operands);
  }
  
  visitVectorExpr(VectorExpr expr) {
    _renderElements(r"[", r";", r"]", buf, expr.operands);
  }
  
  // non-algebraic nary expr
  visitDictionaryExpr(DictionaryExpr expr) {
    _renderElements(r"{", r",", r"}", buf, expr.operands);
  }
  
  visitIntervalExpr(IntervalExpr expr) {
    expr.start.asString(buf);
    buf.write("..");
    if(expr.step is! NothingExpr) {
      expr.step.asString(buf);
      buf.write("..");
    }
    expr.end.asString(buf);
  }
  
  StringBuffer get buf;
}

abstract class StringNullaryExprVisitor implements NullaryExprVisitor {
  visitBoolExpr(BoolExpr expr) => _visitNullaryExpr(expr);
  
  visitNumberExpr(NumberExpr expr) => _visitNullaryExpr(expr);
  
  visitStringExpr(StringExpr expr) => _visitNullaryExpr(expr);
  
  visitSymbolExpr(SymbolExpr expr) => _visitNullaryExpr(expr);
  
  _visitNullaryExpr(NullaryExpr expr) => buf.write(expr.value);
  
  StringBuffer get buf;
}

abstract class StringSpecialExprVisitor implements SpecialExprVisitor {
  
}

abstract class StringUnaryExprVisitor implements UnaryExprVisitor {
  visitFactorialExpr(FactorialExpr expr) {
    expr.operand.visit(visitor);
    buf.write(expr.token);
  }
  
  visitNegationExpr(NegationExpr expr) {
    buf.write(expr.token);
    expr.operand.visit(visitor);
  }
  
  visitNegativeExpr(NegativeExpr expr) {
    buf.write(expr.token);
    expr.operand.visit(visitor);
  }
  
  StringBuffer get buf;
  
  ExprVisitor get visitor;
}