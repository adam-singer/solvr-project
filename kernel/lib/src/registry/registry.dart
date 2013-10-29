// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_registry;

/** Facade for looking up scoped and loaded values/functions/methods */
class Registry {
  Registry() {
    pushScope();
  }

  pushScope() {
    _currentScope = new Scope();
    _scopes.addFirst(_currentScope);
  }

  popScope() {
    _scopes.removeFirst();
    _currentScope = _scopes.first;
  }

  resetScopes() {
    _scopes.clear();
    pushScope();
  }

  /** Lookup symbol value, returns null if symbol is not bound to a value */
  Expr lookupSymbol(SymbolExpr symb) {
    Expr res = null;
    _scopes.forEach((scope) {
      if(scope.isKnownSymbol(symb)) {
        res = scope.getSymbolValue(symb);
        return;
      } else if(scope.isBound(symb)) {
        /* if we did not find it and the variable is bound then stop looking.
          - ex:
          x = 2
          f(x) {
            g(y) = y + x^2;
            g(x)
          }
          f(x)

          - x is free in g so it can be looked up in g
          - x is bound in f so it can be looked up in f but not replaced by values outside f (x=2)
         */
        return;
      }
    });
    return res;
  }

  /** Lookup method on type, throws exception if no such method exists on type */
  MethodObject getMethod(MethodExpr methodInvocation) {
    if(!isKnownMethod(methodInvocation)) {
      throw "method ${methodInvocation.name} does not exists on type ${methodInvocation.target.type}";
    }
    return _loader.getMethodFor(methodInvocation.name, methodInvocation.target.type);
  }

  bool isKnownMethod(MethodExpr methodInvocation) => isMethodOn(methodInvocation.target.type, methodInvocation.name);

  bool isMethodOn(IType targetType, String methodName) => (_loader.getMethodFor(methodName, targetType) != null);

  /** Lookup function, throws exception if no such function exists */
  FunctionObject getFunction(InvokeExpr invocation) {
    // TODO look in scope first
    if(!isKnownFunction(invocation)) {
      throw "function ${invocation} does not exists";
    }
    return _loader.getFunctionFor(invocation.name, invocation.args);
  }

  bool isKnownFunction(InvokeExpr invocation) => (_loader.getFunctionFor(invocation.name, invocation.args) != null);

  bool isKnownSymbol(SymbolExpr symb) {
    bool res = false;
    _scopes.forEach((Scope scope) {
      if(scope.isKnownSymbol(symb)) {
        res = true;
        return;
      } else if(scope.isBound(symb)) {
        return;
      }
    });
    return res;
  }

  /** Bind symbol so it cannot take part in substitution */
  bindSymbols(List<SymbolExpr> symbols) => _currentScope.bindSymbols(symbols);

  /** Register a symbol value */
  registerSymbol(SymbolExpr variable, Expr value) => _currentScope.registerSymbol(variable, value);

  /** Get known areas */
  Iterable<AreaType> get areas => _loader.areas;

  /** Get map of known functions for a given area */
  Map<String, List<FunctionObject>> getFunctionsFor(AreaType area) => _loader.getFunctionsFor(area);

  final _scopes = new Queue<Scope>();
  final _loader = new Loader();
  Scope _currentScope;
}

