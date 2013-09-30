// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Reduce objects and handle object operators */
class ObjectReducer extends Reducer<Expr> {
  ObjectReducer(this._simplifier);

  Expr reduce(Expr expr) {
    if(isObject(expr)) {
      return _reduceObject(expr);
    } else if(isObjectOperator(expr)) {
      return _reduceObjectExpression(expr);
    }
  }

  Expr _reduceObject(var object) {
    // handle objects that might need to have their internal elements reduced
    // such as lists, sets, tuples, vectors, dictionaries, matrices
    if(isTuple(object)) {
      return _simplifier.simplifyTuple(object);
    } else if(isSet(object)) {
      return _simplifier.simplifySet(object);
    } else {
      return object;
    }
  }

  Expr _reduceObjectExpression(var expr) {
    // TODO instance of operators
    return expr;
  }

  final AutomaticSimplifier _simplifier;
  static final _logger = LoggerFactory.getLoggerFor(ObjectReducer);
}
