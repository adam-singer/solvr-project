// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/**
 * Represents a node in the abstract syntax tree
 *
 * Precedences flows down in the tree so the root node in each
 * parentheses group has the lowest priority.
 * 
 * Note that expressions are weakly typed in the AST as only very few type 
 * checks are done by the parser. The type checker will run after the parser
 * to analyze that the types used in the AST are corret.
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

  /** The original location of the expression, mostly used when reporting errors */
  Location location;

  /** Pointer to parent node, null when at the root */
  Expr parent;

  /** Get the entire expression as a string starting from the root */
  String fullString() {
    ExprVisitor visitor = new StringExprVisitor();
    root.visit(visitor);
    return visitor.toString();
  }

  /** Get current expression as a string */
  String toString() {
    ExprVisitor visitor = new StringExprVisitor();
    this.visit(visitor);
    return visitor.toString();
  }

  /** True when other expression is of the same type as this */
  bool hasSameType(Expr other) => other.runtimeType == this.runtimeType;

  /** Map a function over the expressions operands, this modifies the tree in place! */
  Expr map(ExprConverter morpher); 
  
  // TODO rename to accept
  /** Visit expression */
  visit(ExprVisitor visitor);

  /** Get the operands for this expression */
  List<Expr> get operands;

  /** Get a deep clone of this exprssion */
  Expr get clone;

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

  operator +(Expr other) => asSum([this, other]);

  operator -(Expr other) => asDifference(this, other);

  operator *(Expr other) => asProduct([this, other]);

  operator /(Expr other) => asFraction(this, other);

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

  // Binary algebraic expressions
  static Expr differenceExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr((left - right), location);
  }

  static Expr dotExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asDot(left, right), location);
  }

  static Expr fractionExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr((left/right), location);
  }

  static Expr powerExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asPower(left, right), location);
  }

  static Expr productExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr((left * right), location);
  }

  static Expr sumExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr((left + right), location);
  }

  // Binary logical expressions
  static Expr andExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asAnd(left, right), location);
  }

  static Expr orExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asOr(left, right), location);
  }

  // Binary object expressions
  static Expr bindExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asBind(left, right), location);
  }

  static Expr guardExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asGuard(left, right), location);
  }

  static Expr instanceOfExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asInstanceOf(left, right), location);
  }

  static Expr notInstanceOfExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asNotInstanceOf(left, right), location);
  }

  static Expr substitutionExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asSubstitution(left, right), location);
  }

  // Binary relational expressions
  static Expr equalExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asEqual(left, right), location);
  }

  static Expr notEqualExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asNotEqual(left, right), location);
  }

  static Expr greaterThanExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asGreaterThan(left, right), location);
  }

  static Expr greaterThanOrEqualExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asGreaterThanOrEqual(left, right), location);
  }

  static Expr lessThanExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asLessThan(left, right), location);
  }

  static Expr lessThanOrEqualExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asLessThanOrEqual(left, right), location);
  }

  // Binary set expressions
  static Expr complementExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asComplement(left, right), location);
  }

  static Expr entryExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asEntry(left, right), location);
  }

  static Expr intersectExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asIntersect(left, right), location);
  }

  static Expr notSubsetExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asNotSubset(left, right), location);
  }

  static Expr subsetExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asSubset(left, right), location);
  }

  static Expr unionExpr(Expr left, Expr right, [Location location = null]) {
    return _createExpr(asUnion(left, right), location);
  }

  // Nary expressions
  static Expr dictionaryExpr(List<Expr> elements, [Location location = null]) {
    return _createExpr(asDictionary(elements), location);
  }

  static Expr intervalExpr(Expr start, Expr step, Expr end, [Location location = null]) {
    return _createExpr(asInterval(start, step, end), location);
  }

  static Expr listExpr(List<Expr> elements, [Location location = null]) {
    return _createExpr(asList(elements), location);
  }

  static Expr matrixExpr(List<VectorExpr> elements, [Location location = null]) {
    return _createExpr(asMatrix(elements), location);
  }

  static Expr setExpr(List<Expr> elements, [Location location = null]) {
    return _createExpr(asSet(elements), location);
  }

  static Expr tupleExpr(List<Expr> elements, [Location location = null]) {
    return _createExpr(asTuple(elements), location);
  }

  static Expr vectorExpr(List<Expr> elements, [Location location = null]) {
    return _createExpr(asVector(elements), location);
  }

  // Nullary expressions 
  static Expr boolExpr(String value, [Location location = null]) {
    return _createExpr(asBool(value == "true"), location);
  }

  static Expr integerExpr(String value, [Location location = null]) {
    return _createExpr(asInteger(value), location);
  }

  static Expr realExpr(String value, [Location location = null]) {
    return _createExpr(asReal(value), location);
  }

  static Expr symbolExpr(String value, [Location location = null]) {
    return _createExpr(asSymbol(value), location);
  }

  static Expr stringExpr(String value, [Location location = null]) {
    return _createExpr(asString(value), location);
  }

  // Special expressions 
  static Expr anonymousFunctionExpr(TupleExpr args, Expr body, [Location location = null]) {
    return _createExpr(asAnonymousFunction(args, body), location);
  }

  static Expr assignExpr(SymbolExpr variable, Expr value, [Location location = null]) {
    return _createExpr(asAssign(variable, value), location);
  }

  static Expr blockExpr(List<Expr> content, [Location location = null]) {
    return _createExpr(asBlock(content), location);
  }

  static Expr conditionalExpr(Expr condition, Expr ifBody, Expr elsePart, [Location location = null]) {
    return _createExpr(asConditional(condition, ifBody, elsePart), location);
  }

  static Expr functionExpr(String name, TupleExpr args, Expr body, [Location location = null]) {
    return _createExpr(asFunction(name, args, body), location);
  }

  static Expr invokeExpr(String name, TupleExpr args, [Location location = null]) {
    return _createExpr(asInvoke(name, args), location);
  }

  static Expr methodExpr(ObjectExpr target, String name, TupleExpr args, [Location location = null]) {
    return _createExpr(asMethod(target, name, args), location);
  }

  static Expr nothingExpr([Location location = null]) {
    return _createExpr(asNothing(), location);
  }

  static Expr returnExpr(Expr value, [Location location = null]) {
    return _createExpr(asReturn(value), location);
  }

  static Expr seqExpr(List<Expr> arguments, Expr body, [Location location = null]) {
    return _createExpr(asSeq(arguments, body), location);
  }

  static Expr typedExpr(Expr key, Expr value, [Location location = null]) {
    return _createExpr(asTyped(key, value), location);
  }

  // Unary expressions 
  static Expr factorialExpr(Expr operand, [Location location = null]) {
    return _createExpr(factorial(operand), location);
  }

  static Expr negationExpr(BoolExpr operand, [Location location = null]) {
    return _createExpr(negation(operand), location);
  }

  static Expr negativeExpr(Expr operand, [Location location = null]) {
    return _createExpr(negative(operand), location);
  }

  // Helpers 
  static Expr _createExpr(Expr expr, Location location) {
    expr.location = location;
    return expr;
  }
}

/** Visit and alter a expression operand into a new form */
typedef Expr ExprConverter(Expr expr);

/** Return true if a expr is matched by the function */
typedef bool ExprMatcher(Expr expr);
