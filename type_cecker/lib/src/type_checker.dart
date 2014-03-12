// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_type_checker;

/** Simple type checker/inferencer */
class TypeChecker {
  TypeChecker(Registry registry) {
    _algebraicChecker = new AlgebraicChecker(this, registry);
    _logicalChecker = new LogicalChecker(this, registry);
    _objectChecker = new ObjectChecker(this, registry);
    _relationalChecker = new RelationalChecker(this, registry);
    _setChecker = new SetChecker(this, registry);
  }

  /** Check expressions */
  bool check(Expr expr) {
    errors.clear();
    _inContext("check", expr, _checkRec);
    return errors.isEmpty;
  }

  _checkRec(Expr expr) {
    if(isNullary(expr)) {
      return;
    }
    // recursivly check the expression exprs
    expr = expr.visit(_checkRec);
    if(isAlgebraicOperator(expr)) {
      _inContext("algebraic", expr, _algebraicChecker.check);
    } else if(isLogicalOperator(expr)) {
      _inContext("logical", expr, _logicalChecker.check);
    } else if(isObjectOperator(expr)) {
      _inContext("object", expr, _objectChecker.check);
    } else if(isRelationalOperator(expr)) {
      _inContext("relational", expr, _relationalChecker.check);
    } else if(isSetOperator(expr)) {
      _inContext("set", expr, _setChecker.check);
    }
    _logger.warn("unhandled type check for expression $expr");
  }

  // evaluates [f] in a logging diagnostic context named [contextName]
  _inContext(String contextName, Expr expr, Expr f(Expr)) => inContext(_logger, contextName, expr, f);

  // TODO add position to error
  error(String msg) => errors.add(msg);
  
  Checker _algebraicChecker, _logicalChecker, _objectChecker, _relationalChecker, _setChecker;
  final errors = new List<String>();
  static final _logger = LoggerFactory.getLoggerFor(TypeChecker);
}
