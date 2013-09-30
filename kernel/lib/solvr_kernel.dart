// Copyright (c) 2013 Solvr. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

library solvr_kernel;

import 'src/ast_lib.dart';
export 'src/ast_lib.dart';
import 'src/parser_lib.dart';
// TODO perhaps move all error classes into a common place (creates problems if they need access to internals)
export 'src/parser_lib.dart' show ParserError;
import 'src/math_lib.dart';

/** Facade for our mathematical functions and expression handling */
class Kernel {
  /**
   * Get a kernel with a new scope 
   *
   * Use [Kernel.keepScope()] to get [Kernel] with access to any values bound in prior scopes
   */
  factory Kernel.newScope() {
    var registry = new Registry();
    var simplifier = new AutomaticSimplifier(registry);
    var checker = new TypeChecker(registry);
    var resolver = new Resolver(registry);
    return new Kernel._internal(simplifier, checker, registry, resolver);
  }
  
  /** Get a [Kernel] with access to the last run scope */
  factory Kernel.keepScope() {
    // TODO insane solution, find some other way of doing this
    // TODO do we need this constructor (only used in unit tests)
    if(_instance == null) {
      _instance = new Kernel.newScope();
    }
    return _instance;
  }
  
  Kernel._internal(this._simplifier, this._checker, this._registry, this._resolver);
  
  /**
   * Get possible function matches for expresssion. 
   *
   * TODO implement and use for tab completion
   */
  List functionMatches(String expression) {
    throw 'TODO'; 
  }
  
  /** Evaluate expression by parsing, resolving, type checking and finally simplifying it */
  Expr evaluate(String expression) {
    Expr expr;
    try {
      expr = parse(expression);
      expr = resolve(expr);
      expr = check(expr);
      expr = simplify(expr);
    } on ExprUndefinedError catch(ex) {
      // mathematically undefined expression
      expr = asSymbol('undefined');
    } 
    // TODO move error handler into own function so it can be shared and used in inf to show errors
    //on ExprError catch(ex) {
    // TODO show expression error message
    //} on KernelError catch(ex, stack) {
    // TODO show internal kernel error message, report to backend
    //} on SolvrError catch(ex, stack) {
    // TODO show system error message, report to backend
    //} catch(ex, stack) {
    // TODO show fatal error message, report to backend
    //}
    return expr;
  }
  
  /** Parse expression */
  Expr parse(String expression) {
    var parser = new InputParser(expression);
    return parser.parse();
  }
  
  /** Type check expression */
  Expr check(Expr expression) {
    //if(!_checker.check(expression)) {
    //  throw new ExpressionTypeException(expression, _typeChecker.errors);
    //}
    return expression;
  }
  
  /** Resolve expression by substituting values of known variables and functions */
  Expr resolve(Expr expression) => _resolver.resolve(expression);
  
  /** Simplify expression */
  Expr simplify(Expr expression) => _simplifier.simplify(expression);
  
  /**
   * Clear variable bindings and cached calculations from the kernel!.
   */
  resetScope() {
    _registry.resetScopes();
  }
  
  final AutomaticSimplifier _simplifier;
  final TypeChecker _checker;
  final Registry _registry;
  final Resolver _resolver;
  static Kernel _instance;
}
