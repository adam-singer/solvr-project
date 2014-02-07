// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Execute function/method invocations and reduce their results */
class InvokeReducer extends Reducer<Expr> {
  InvokeReducer(this._simplifier, this._registry);

  Expr reduce(Expr expr) {
    try {
      if(isInvoke(expr)) {
        return _reduceInvoke(expr);
      } else if(isMethod(expr)) {
        return _reduceMethod(expr);
      }
    } on ExprInvocationUndefinedError catch(ex) {
      // record expression that failed and rethrow
      ex.expr = expr;
      throw ex;
    }
    throw new KernelError("unknown invocation type $expr");
  }

  Expr _reduceInvoke(InvokeExpr invocation) {
    if(!_registry.isKnownFunction(invocation)) {
      // as we can calculate with undefined functions, just return the expression
      _logger.debug("no function to invoke for ${invocation.name}");
      return invocation;
    }

    var function = _registry.getFunction(invocation);
    var res = function.invoke(invocation.args);
    _logger.debug("invoked function ${invocation.name} with arguments ${invocation.args} and got result $res");
    assert(res != null);
    return _simplifyResult(res);
  }

  Expr _reduceMethod(MethodExpr invocation) {
    var method = _registry.getMethod(invocation);
    var res = method.invokeOn(invocation.target, invocation.args);
    _logger.debug("invoked method ${invocation.name} with arguments ${invocation.args} and got result $res");
    assert(res != null);
    return _simplifier.simplify(res);
  }

  Expr _simplifyResult(var expr) {
    if(isInvoke(expr)) {
      var args = expr.args.clone;
      var simplified = _simplifier.simplify(args);
      if(simplified != args) {
        expr.args = isTuple(simplified) ? simplified : asTuple(simplified);
        return expr;
      }
      return expr;
    }
    return _simplifier.simplify(expr);
  }

  final AutomaticSimplifier _simplifier;
  final Registry _registry;
  static final _logger = LoggerFactory.getLoggerFor(InvokeReducer);
}
