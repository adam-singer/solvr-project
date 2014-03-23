// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_kernel;

import 'package:solvr_ast/solvr_ast.dart';
import 'package:solvr_parser/solvr_parser.dart';
import 'package:solvr_typechecker/solvr_typechecker.dart';
import 'solvr_kernel_math.dart';

// export the AST and the user errors thrown by the Parser
export 'package:solvr_parser/solvr_parser.dart' show ParserError;
export 'package:solvr_ast/solvr_ast.dart';

// TODO perhaps move all error classes into a common place (creates problems if they need access to internals)
// TODO figure out how dependency injection should be done (fx. internal math functions that needs to call the kernel)

/** Facade for our mathematical functions and expression handling */
abstract class Kernel {
  /**
   * Get a kernel with a new scope 
   *
   * Use [Kernel.withScope] to get [Kernel] with access to any values bound in prior scopes
   */
  factory Kernel() {
    var registry = new Registry();
    return new _SolvrKernel(registry);
  }
  
  /** Get a [Kernel] with access to the last run scope */
  factory Kernel.withScope(Registry registry) {
    return new _SolvrKernel(registry);
  }
  
  /** Get possible function matches for expresssion. */
  List functionMatches(String expression);
  
  /** Evaluate expression by parsing, resolving, type checking and finally simplifying it */
  Expr evaluate(String expression);
  
  /** Parse expression (does not evaluate or simplify it) */
  Expr parse(String expression);
  
  /** Analyze expression for type errors */
  Expr analyze(Expr expression);
  
  /** Resolve expression by substituting values of known variables and functions */
  Expr resolve(Expr expression);
  
  /** Simplify expression */
  Expr simplify(Expr expression);
  
  /** Clear variable bindings and cached calculations from the kernel!. */
  resetScope();
}

class _SolvrKernel implements Kernel { 
  _SolvrKernel(Registry registry):
    _simplifier = new AutomaticSimplifier(registry),
    _checker = new TypeChecker(),
    _resolver = new Resolver(registry),
    _registry = registry;
  
  @override
  List functionMatches(String expression) {
    // TODO implement and use for tab completion
    throw 'TODO'; 
  }
  
  @override
  Expr evaluate(String expression) {
    Expr expr;
    try {
      expr = parse(expression);
      expr = resolve(expr);
      expr = analyze(expr);
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
  
  @override
  Expr parse(String expression) {
    var parser = new SolvrParser(expression);
    return parser.parse();
  }
  
  @override
  Expr analyze(Expr expression) {
    //if(!_checker.check(expression)) {
    //  throw new ExpressionTypeException(expression, _typeChecker.errors);
    //}
    return expression;
  }
  
  @override
  Expr resolve(Expr expression) => _resolver.resolve(expression);
  
  @override
  Expr simplify(Expr expression) => _simplifier.simplify(expression);
  
  @override
  resetScope() => _registry.resetScopes();
  
  final AutomaticSimplifier _simplifier;
  final TypeChecker _checker;
  final Registry _registry;
  final Resolver _resolver;
  static Kernel _instance;
}




