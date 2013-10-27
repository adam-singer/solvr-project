// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/**
 * Represents a node in the abstract syntax tree
 *
 * Precedences flows down in the tree so the root node in each
 * parentheses group has the lowest priority
 */
abstract class Expr {
  static final String languageVersion = "0.1";

  Expr()
    : reduced = false;

  /**
   * Rarely used feature used to mark expression as reduced to avoid expensive simplification
   * calls on things that cannot reduce.
   *
   * Use with care as ususally its a sign of a bug that simplification is run more than once
   */
  bool reduced;

  /** Position is used to track the origin of a expression, mostly used when reporting errors */
  Position position;

  /** Pointer to parent node, null when at the root */
  Expr parent;

  /** Get the entire expression as a string starting from the root */
  String fullString() {
    StringBuffer buf = new StringBuffer();
    root.asString(buf);
    return buf.toString();
  }

  /** Get current expression as a string */
  String toString() {
    StringBuffer buf = new StringBuffer();
    this.asString(buf);
    return buf.toString();
  }

  /** True when other expression is of the same type as this */
  bool hasSameType(Expr other) => other.runtimeType == this.runtimeType;

  /** Render current expression as a string */
  asString(StringBuffer buf);

  /** Map a function over the expressions operands, this modifies the tree in place! */
  Expr map(ExprConverter morpher);
  
  /** Visit expression */
  visit(ExprVisitor visitor);

  /** Get the operands for this expression */
  List<Expr> get operands;

  /** Get a deep clone of this exprssion */
  Expr get clone;
  
  /** TODO remove when math kernel is rewritten to use reflection */
  IType get type;

  /** Get the root node in the expression tree. */
  Expr get root {
    Expr root = this;
    while(root.parent != null) {
      root = root.parent;
    }
    return root;
  }

  /** Determine if two expressions are syntactically equal */
  operator ==(Expr other) => this.toString() == other.toString();

  operator +(Expr other) => new SumExpr([this, other]);

  operator -(Expr other) => new DifferenceExpr(this, other);

  operator *(Expr other) => new ProductExpr([this, other]);

  operator /(Expr other) => new FractionExpr(this, other);

  /** True if this expression matches any of the applied matchers */
  bool anyOf(List<ExprMatcher> matchers) {
    var match = false;
    matchers.forEach((ExprMatcher matcher) {
      if(matcher(this)) {
        match = true;
        return;
      }
    });
    return match;
  }

  /** True if the parent type hirachy matches the list of matchers */
  bool parentsAre(List<ExprMatcher> matchers) {
    var expr = this.parent;
    var matched = true;
    matchers.forEach((ExprMatcher matcher) {
      if(expr == null || !matcher(expr)) {
         matched = false;
         return;
      }
      expr = expr.parent;
    });
    return matched;
  }

  // algebraic expressions
  static Expr differenceExpr(Position position, Expr left, Expr right) {
    return _createExpr((left - right), position);
  }

  static Expr dotExpr(Position position, Expr left, Expr right) {
    return _createExpr(new DotExpr(left, right), position);
  }

  static Expr fractionExpr(Position position, Expr left, Expr right) {
    return _createExpr((left/right), position);
  }

  static Expr powerExpr(Position position, Expr left, Expr right) {
    return _createExpr(power(left, right), position);
  }

  static Expr productExpr(Position position, Expr left, Expr right) {
    return _createExpr((left * right), position);
  }

  static Expr sumExpr(Position position, Expr left, Expr right) {
    return _createExpr((left + right), position);
  }

  // Logical expressions
  static Expr andExpr(Position position, Expr left, Expr right) {
    return _createExpr(and(left, right), position);
  }

  static Expr orExpr(Position position, Expr left, Expr right) {
    return _createExpr(or(left, right), position);
  }

  // Object expressions
  static Expr bindExpr(Position position, Expr left, Expr right) {
    return _createExpr(bind(left, right), position);
  }

  static Expr guardExpr(Position position, Expr left, Expr right) {
    return _createExpr(guard(left, right), position);
  }

  static Expr instanceOfExpr(Position position, Expr left, Expr right) {
    return _createExpr(instanceOf(left, right), position);
  }

  static Expr notInstanceOfExpr(Position position, Expr left, Expr right) {
    return _createExpr(notInstanceOf(left, right), position);
  }

  static Expr substitutionExpr(Position position, Expr left, Expr right) {
    return _createExpr(substitution(left, right), position);
  }

  // Relational expressions
  static Expr equalExpr(Position position, Expr left, Expr right) {
    return _createExpr(equal(left, right), position);
  }

  static Expr notEqualExpr(Position position, Expr left, Expr right) {
    return _createExpr(notEqual(left, right), position);
  }

  static Expr greaterThanExpr(Position position, Expr left, Expr right) {
    return _createExpr(greaterThan(left, right), position);
  }

  static Expr greaterThanOrEqualExpr(Position position, Expr left, Expr right) {
    return _createExpr(greaterThanOrEqual(left, right), position);
  }

  static Expr lessThanExpr(Position position, Expr left, Expr right) {
    return _createExpr(lessThan(left, right), position);
  }

  static Expr lessThanOrEqualExpr(Position position, Expr left, Expr right) {
    return _createExpr(lessThanOrEqual(left, right), position);
  }

  // Set expressions
  static Expr complementExpr(Position position, Expr left, Expr right) {
    return _createExpr(complement(left, right), position);
  }

  static Expr entryExpr(Position position, Expr left, Expr right) {
    return _createExpr(entry(left, right), position);
  }

  static Expr intersectExpr(Position position, Expr left, Expr right) {
    return _createExpr(intersect(left, right), position);
  }

  static Expr notSubsetExpr(Position position, Expr left, Expr right) {
    return _createExpr(notSubset(left, right), position);
  }

  static Expr subsetExpr(Position position, Expr left, Expr right) {
    return _createExpr(subset(left, right), position);
  }

  static Expr unionExpr(Position position, Expr left, Expr right) {
    return _createExpr(union(left, right), position);
  }

  // Nary expressions
  static Expr dictionaryExpr(Position position, List<Expr> elements) {

    return _createExpr(dictionaryOf(elements), position);
  }

  static Expr intervalExpr(Position position, Expr start, Expr step, Expr end) {
    return _createExpr(intervalOf(start, step, end), position);
  }

  static Expr listExpr(Position position, List<Expr> elements) {
    return _createExpr(listOf(elements), position);
  }

  static Expr matrixExpr(Position position, List<VectorExpr> elements) {
    return _createExpr(matrixOf(elements), position);
  }

  static Expr setExpr(Position position, List<Expr> elements) {
    return _createExpr(setOf(elements), position);
  }

  static Expr tupleExpr(Position position, List<Expr> elements) {
    return _createExpr(tupleOf(elements), position);
  }

  static Expr vectorExpr(Position position, List<Expr> elements) {
    return _createExpr(vectorOf(elements), position);
  }

  // Nullary expressions 
  static Expr boolExpr(Position position, String value) {
    return _createExpr(asBool(value == "true"), position);
  }

  static Expr integerExpr(Position position, String value) {
    return _createExpr(asInteger(value), position);
  }

  static Expr realExpr(Position position, String value) {
    return _createExpr(asReal(value), position);
  }

  static Expr symbolExpr(Position position, String value) {
    return _createExpr(asSymbol(value), position);
  }

  static Expr stringExpr(Position position, String value) {
    return _createExpr(stringOf(value), position);
  }

  // Special expressions 
  static Expr anonymousFunctionExpr(Position position, TupleExpr args, Expr body) {
    return _createExpr(asAnonymousFunction(args, body), position);
  }

  static Expr assignExpr(Position position, SymbolExpr variable, Expr value) {
    return _createExpr(asAssign(variable, value), position);
  }

  static Expr blockExpr(Position position, List<Expr> content) {
    return _createExpr(asBlock(content), position);
  }

  static Expr conditionalExpr(Position position, Expr condition, Expr ifBody, Expr elsePart) {
    return _createExpr(asConditional(condition, ifBody, elsePart), position);
  }

  static Expr functionExpr(Position position, String name, TupleExpr args, Expr body) {
    return _createExpr(asFunction(name, args, body), position);
  }

  static Expr genericExpr(Position position, Expr template, List<Expr> boundaries) {
    return _createExpr(asGeneric(template, boundaries), position);
  }

  static Expr invokeExpr(Position position, String name, TupleExpr args) {
    return _createExpr(asInvoke(name, args), position);
  }

  static Expr methodExpr(Position position, ObjectExpr target, String name, TupleExpr args) {
    return _createExpr(asMethod(target, name, args), position);
  }

  static Expr nothingExpr(Position position) {
    return _createExpr(asNothing(), position);
  }

  static Expr returnExpr(Position position, Expr value) {
    return _createExpr(asReturn(value), position);
  }

  static Expr seqExpr(Position position, List<Expr> arguments, Expr body) {
    return _createExpr(asSeq(arguments, body), position);
  }

  static Expr typedExpr(Position position, Expr key, Expr value) {
    return _createExpr(asTyped(key, value), position);
  }

  // Unary expressions 
  static Expr factorialExpr(Position position, Expr operand) {
    return _createExpr(factorial(operand), position);
  }

  static Expr negationExpr(Position position, BoolExpr operand) {
    return _createExpr(negation(operand), position);
  }

  static Expr negativeExpr(Position position, Expr operand) {
    return _createExpr(negative(operand), position);
  }

  // Helpers 
  static Expr _createExpr(Expr expr, Position position) {
    expr.position = position;
    return expr;
  }
}

/** Visit and alter a expression operand into a new form */
typedef Expr ExprConverter(Expr expr);

/** Return true if a expr is matched by the function */
typedef bool ExprMatcher(Expr expr);
