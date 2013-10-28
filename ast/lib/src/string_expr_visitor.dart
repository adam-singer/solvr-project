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
  
  String toString() => buf.toString();
  
  clear() => buf.clear();
  
  final StringBuffer buf = new StringBuffer();
}

abstract class StringBinaryExprVisitor implements BinaryExprVisitor {
  visitComplexNumberExpr(ComplexNumberExpr expr) {
    expr.left.visit(visitor);
    buf.write(" ${expr.token} i");
    expr.right.visit(visitor);
  }
  
  visitDifferenceExpr(DifferenceExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitDotExpr(DotExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitFractionExpr(FractionExpr expr) => _visitSimpleBinaryExpr(expr, padding:"");
  
  visitPowerExpr(PowerExpr expr) => _visitSimpleBinaryExpr(expr, padding:"");
  
  visitAndExpr(AndExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitOrExpr(OrExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitBindExpr(BindExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitGuardExpr(GuardExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitInstanceOfExpr(InstanceOfExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitNotInstanceOfExpr(NotInstanceOfExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitSubsitutionExpr(SubstitutionExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitEqualExpr(EqualExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitGreaterThanExpr(GreaterThanExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitGreaterThanOrEqualExpr(GreaterThanOrEqualExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitLessThanExpr(LessThanExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitLessThanOrEqualExpr(LessThanOrEqualExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitNotEqualExpr(NotEqualExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitComplementExpr(ComplementExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitEntryExpr(EntryExpr expr) => _visitSimpleBinaryExpr(expr, padding:"");
  
  visitIntersectExpr(IntersectExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitNotSubsetExpr(NotSubsetExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitSubsetExpr(SubsetExpr expr) => _visitSimpleBinaryExpr(expr);
  
  visitUnionExpr(UnionExpr expr) => _visitSimpleBinaryExpr(expr);
  
  _visitSimpleBinaryExpr(BinaryExpr expr, {String padding:" "}) {
    expr.left.visit(visitor);
    buf.write("${padding}${expr.token}${padding}");
    expr.right.visit(visitor);
  }
  
  StringBuffer get buf;
  
  ExprVisitor get visitor;
}

abstract class StringNaryExprVisitor implements NaryExprVisitor {
  visitProductExpr(ProductExpr expr) {
    if(expr.operands[0].toString() == "-1") {
      // -1 * x * y * .. = -x * y * ...
      buf.write(r"-");
      _visitElements("", r" * ", "", buf, visitor, tail(expr.operands));
    } else {
      _visitElements("", r" * ", "", buf, visitor, expr.operands);
    }
  }
  
  visitSumExpr(SumExpr expr) => _visitElements("", r" + ", "", buf, visitor, expr.operands);
  
  visitListExpr(ListExpr expr) {
    _visitElements(r"[", r",", r"]", buf, visitor, expr.operands);
  }
  
  visitMatrixExpr(MatrixExpr expr) {
    buf.write(r"[");
    mapI(expr.operands, (Expr row, int i) {
      row.visit(visitor);
      if(i < expr.operands.length - 1) buf.write(r";");
    });
    buf.write(r"]");
  }
  
  visitSetExpr(SetExpr expr) {
    _visitElements(r"{", r",", r"}", buf, visitor, expr.operands);
  }
  
  visitTupleExpr(TupleExpr expr) {
    _visitElements(r"(", r",", r")", buf, visitor, expr.operands);
  }
  
  visitVectorExpr(VectorExpr expr) {
    _visitElements(r"[", r";", r"]", buf, visitor, expr.operands);
  }
  
  visitDictionaryExpr(DictionaryExpr expr) {
    _visitElements(r"{", r",", r"}", buf, visitor, expr.operands);
  }
  
  visitIntervalExpr(IntervalExpr expr) {
    expr.start.visit(visitor);
    buf.write("..");
    if(expr.step is! NothingExpr) {
      expr.step.visit(visitor);
      buf.write("..");
    }
    expr.end.visit(visitor);
  }
  
  StringBuffer get buf;
  
  ExprVisitor get visitor;
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
  visitAnonymousFunctionExpr(AnonymousFunctionExpr expr) {
    expr.args.visit(visitor);
    buf.write(r" => ") ;
    expr.body.visit(visitor);
  }
  
  visitAssignExpr(AssignExpr expr) {
    expr.variable.visit(visitor);
    buf.write(r" = ");
    expr.value.visit(visitor);
  }
  
  visitBlockExpr(BlockExpr expr) {
    _visitElements("{\n  ", "\n  ", "\n}", buf, visitor, expr.operands);
  }
  
  visitConditionalExpr(ConditionalExpr expr) {
    buf.write("if");
    expr.condition.visit(visitor);
    expr.ifBody.visit(visitor);
    if(expr.elsePart is! NothingExpr) {
      buf.write("else");
      expr.elsePart.visit(visitor);
    }
  }
  
  visitFunctionExpr(FunctionExpr expr) {
    if(expr.hasReturnType()) {
      expr.returnType.visit(visitor);
    }
    buf.write(expr.name);
    expr.args.visit(visitor);
    if(expr.body is! BlockExpr) {
      buf.write(r" = ");
    }
    expr.body.visit(visitor);
  }
  
  visitGenericExpr(GenericExpr expr) {
    expr.template.visit(visitor);
    _visitElements("<", r"|", ">", buf, visitor, expr.operands);
  }
  
  visitInvokeExpr(InvokeExpr expr) {
    buf.write(expr.name);
    expr.args.visit(visitor);
  }
  
  visitMethodExpr(MethodExpr expr) {
    expr.target.visit(visitor);
    buf.write(".${expr.name}");
    expr.args.visit(visitor);
  }
  
  visitNothingExpr(NothingExpr expr) {
    // nothing
  }
  
  visitReturnExpr(ReturnExpr expr) {
    buf.write("return ");
    expr.value.visit(visitor);
  }
  
  visitSeqExpr(SeqExpr expr) {
    buf.write(r"{");
    _visitElements("", r", ", "", buf, visitor, expr.args);
    buf.write(r" | ");
    expr.body.visit(visitor);
    buf.write(r"}");
  }
  
  visitTypedExpr(TypedExpr expr) {
    expr.key.visit(visitor);
    buf.write(r" ");
    expr.value.visit(visitor);
  }
  
  StringBuffer get buf;
  
  ExprVisitor get visitor;
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

/** Renders collection of [elements] inside [start] and [end] with elements delimited by [delimiter] */
_visitElements(String start, String delimiter, String end, StringBuffer buf, ExprVisitor visitor, Iterable<Expr> elements) {
  buf.write(start);
  mapI(elements, (Expr elm, int i) {
    elm.visit(visitor);
    if(i < elements.length - 1) buf.write(delimiter);
  });
  buf.write(end);
}

