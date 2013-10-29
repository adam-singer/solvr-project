// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_resolver;

/** Performs basic modifications of the AST for handling function/variable scoping */
class Resolver {
  Resolver(this._registry);

  Expr resolve(Expr expr) => _resolveRec(expr);

  Expr _resolveRec(var expr) {
    if(isNullary(expr)) {
      if(isSymbol(expr)) {
        return _resolveSymbol(expr);
      }
      return expr;
    } else if(isFunction(expr)) {
      // bind arguments to new scope prior to running recursive resolve
      // to ensure they are not replaced by values from outer scopes
      _registry.pushScope();
      _registry.bindSymbols(expr.args.operands);
    }

    expr = expr.map(_resolveRec);
    if(isDot(expr)) {
      return _resolveDot(expr);
    } else if(isAssign(expr)) {
      return _resolveAssign(expr);
    } else if(isFunction(expr)) {
      // unbind argument scope now that recursive resolve is finished
      _registry.popScope();
      return _resolveFn(expr);
    } else if(isTyped(expr)) {
      return _resolveTyped(expr);
    }
    return expr;
  }

  Expr _resolveDot(var expr) {
    if(isObject(expr.left) && isInvoke(expr.right)) {
      // case x.fn(): when x is an object then fn() must be a method on it
      expr = _asMethod(expr.left, expr.right);
      _logger.debug("converted dot expression into method: $expr");
    }
    return expr;
  }

  Expr _resolveAssign(AssignExpr expr) {
    _logger.debug("register symbol ${expr.variable} with value ${expr.value}");
    _registry.registerSymbol(expr.variable, expr.value);
    // TODO register variables and check for non recursive (initial) variable declarations (x = x + 1)
    return expr;
  }

  Expr _resolveFn(FunctionExpr expr) {
    // TODO register function
    return expr;
  }

  Expr _resolveTyped(TypedExpr expr) {
    // TODO desugar pair's as either bounded symbols (String s) or bounded return types (String f(...))
    // everything else is a error
    return expr;
  }

  Expr _resolveSymbol(SymbolExpr symb) {
    if(_registry.isKnownSymbol(symb)) {
      Expr replaced = _registry.lookupSymbol(symb);
      _logger.debug("replaced symbol $symb with $replaced");
      return replaced;
    }
    _logger.debug("returning unbound symbol $symb");
    return symb;
  }

  MethodExpr _asMethod(Expr target, InvokeExpr invocation) {
    if(!_registry.isMethodOn(target.type, invocation.name)) {
      // unlike undefined functions, missing methods always results in an error
      throw "expr ${target.type} does not define function ${invocation.name}";
    }
    // TODO check arguments
    return new MethodExpr(target, invocation.name, invocation.args);
  }

  final Registry _registry;
  static final _logger = LoggerFactory.getLoggerFor(Resolver);
}
