// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Visitor that visits node and stores its content in a string buffer */
class StringExprVisitor extends Object with 
  BinaryExprStringVisitor,
  NaryExprStringVisitor, 
  NullaryExprStringVisitor, 
  StringSpecialExprVisitor,
  UnaryExprStringVisitor implements ExprVisitor {
  
  ExprVisitor get visitor => this;
  
  String toString() => buf.toString();
  
  clear() => buf.clear();
  
  final StringBuffer buf = new StringBuffer();
}

abstract class BinaryExprStringVisitor implements BinaryExprVisitor {
  @override
  visitComplexNumberExpr(ComplexNumberExpr expr) {
    expr.left.visit(visitor);
    buf.write(" ${expr.token} i");
    expr.right.visit(visitor);
  }
  
  @override
  visitDifferenceExpr(DifferenceExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitDotExpr(DotExpr expr) => _visitSimpleBinaryExpr(expr, padding:"");
  
  @override
  visitFractionExpr(FractionExpr expr) => _visitSimpleBinaryExpr(expr, padding:"");
  
  @override
  visitPowerExpr(PowerExpr expr) => _visitSimpleBinaryExpr(expr, padding:"");
  
  @override
  visitAndExpr(AndExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitOrExpr(OrExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitBindExpr(BindExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitGuardExpr(GuardExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitInstanceOfExpr(InstanceOfExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitNotInstanceOfExpr(NotInstanceOfExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitSubsitutionExpr(SubstitutionExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitEqualExpr(EqualExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitGreaterThanExpr(GreaterThanExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitGreaterThanOrEqualExpr(GreaterThanOrEqualExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitLessThanExpr(LessThanExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitLessThanOrEqualExpr(LessThanOrEqualExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitNotEqualExpr(NotEqualExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitComplementExpr(ComplementExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitEntryExpr(EntryExpr expr) => _visitSimpleBinaryExpr(expr, padding:"");
  
  @override
  visitIntersectExpr(IntersectExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitNotSubsetExpr(NotSubsetExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitSubsetExpr(SubsetExpr expr) => _visitSimpleBinaryExpr(expr);
  
  @override
  visitUnionExpr(UnionExpr expr) => _visitSimpleBinaryExpr(expr);
  
  _visitSimpleBinaryExpr(BinaryExpr expr, {String padding:" "}) {
    expr.left.visit(visitor);
    buf.write("${padding}${expr.token}${padding}");
    expr.right.visit(visitor);
  }
  
  StringBuffer get buf;
  
  ExprVisitor get visitor;
}

abstract class NaryExprStringVisitor implements NaryExprVisitor {
  @override
  visitProductExpr(ProductExpr expr) {
    if(expr.operands[0].toString() == "-1") {
      // -1 * x * y * .. = -x * y * ...
      buf.write(r"-");
      _visitElements("", r" * ", "", buf, visitor, tail(expr.operands));
    } else {
      _visitElements("", r" * ", "", buf, visitor, expr.operands);
    }
  }
  
  @override
  visitSumExpr(SumExpr expr) => _visitElements("", r" + ", "", buf, visitor, expr.operands);
  
  @override
  visitListExpr(ListExpr expr) {
    _visitElements(r"[", r",", r"]", buf, visitor, expr.operands);
  }
  
  @override
  visitMatrixExpr(MatrixExpr expr) {
    buf.write(r"[");
    mapI(expr.operands, (Expr row, int i) {
      row.visit(visitor);
      if(i < expr.operands.length - 1) buf.write(r";");
    });
    buf.write(r"]");
  }
  
  @override
  visitSetExpr(SetExpr expr) {
    _visitElements(r"{", r",", r"}", buf, visitor, expr.operands);
  }
  
  @override
  visitTupleExpr(TupleExpr expr) {
    _visitElements(r"(", r",", r")", buf, visitor, expr.operands);
  }
  
  @override
  visitVectorExpr(VectorExpr expr) {
    _visitElements(r"[", r";", r"]", buf, visitor, expr.operands);
  }
  
  @override
  visitDictionaryExpr(DictionaryExpr expr) {
    _visitElements(r"{", r",", r"}", buf, visitor, expr.operands);
  }
  
  @override
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

abstract class NullaryExprStringVisitor implements NullaryExprVisitor {
  @override
  visitBoolExpr(BoolExpr expr) => _visitNullaryExpr(expr);
  
  @override
  visitNumberExpr(NumberExpr expr) => _visitNullaryExpr(expr);
  
  @override
  visitStringExpr(StringExpr expr) => _visitNullaryExpr(expr);
  
  @override
  visitSymbolExpr(SymbolExpr expr) => _visitNullaryExpr(expr);
  
  _visitNullaryExpr(NullaryExpr expr) => buf.write(expr.value);
  
  StringBuffer get buf;
}

abstract class StringSpecialExprVisitor implements SpecialExprVisitor {
  @override
  visitAnonymousFunctionExpr(AnonymousFunctionExpr expr) {
    expr.args.visit(visitor);
    buf.write(r" => ") ;
    expr.body.visit(visitor);
  }
  
  @override
  visitAssignExpr(AssignExpr expr) {
    expr.variable.visit(visitor);
    buf.write(r" = ");
    expr.value.visit(visitor);
  }
  
  @override
  visitBlockExpr(BlockExpr expr) {
    _visitElements("{\n  ", "\n  ", "\n}", buf, visitor, expr.operands);
  }
  
  @override
  visitConditionalExpr(ConditionalExpr expr) {
    buf.write("if");
    expr.condition.visit(visitor);
    expr.ifBody.visit(visitor);
    if(expr.elsePart is! NothingExpr) {
      buf.write("else");
      expr.elsePart.visit(visitor);
    }
  }
  
  @override
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
  
  @override
  visitGenericExpr(GenericExpr expr) {
    expr.template.visit(visitor);
    _visitElements("<", r"|", ">", buf, visitor, expr.operands);
  }
  
  @override
  visitInvokeExpr(InvokeExpr expr) {
    buf.write(expr.name);
    expr.args.visit(visitor);
  }
  
  @override
  visitMethodExpr(MethodExpr expr) {
    expr.target.visit(visitor);
    buf.write(".${expr.name}");
    expr.args.visit(visitor);
  }
  
  @override
  visitNothingExpr(NothingExpr expr) {
    // nothing
  }
  
  @override
  visitReturnExpr(ReturnExpr expr) {
    buf.write("return ");
    expr.value.visit(visitor);
  }
  
  @override
  visitSeqExpr(SeqExpr expr) {
    buf.write(r"{");
    _visitElements("", r", ", "", buf, visitor, expr.args);
    buf.write(r" | ");
    expr.body.visit(visitor);
    buf.write(r"}");
  }
  
  @override
  visitTypedExpr(TypedExpr expr) {
    expr.key.visit(visitor);
    buf.write(r" ");
    expr.value.visit(visitor);
  }
  
  StringBuffer get buf;
  
  ExprVisitor get visitor;
}

abstract class UnaryExprStringVisitor implements UnaryExprVisitor {
  @override
  visitFactorialExpr(FactorialExpr expr) {
    expr.operand.visit(visitor);
    buf.write(expr.token);
  }
  
  @override
  visitNegationExpr(NegationExpr expr) {
    buf.write(expr.token);
    expr.operand.visit(visitor);
  }
  
  @override
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

