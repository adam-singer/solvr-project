// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Put an expressions on automatic simplified form */
class AutomaticSimplifier {
  factory AutomaticSimplifier(Registry registry) {
    if(_instance == null) {
      _instance = new AutomaticSimplifier._internal(registry);
    }
    return _instance;
  }

  AutomaticSimplifier._internal(Registry registry) {
    // algebraic reducers
    _dotReducer = new DotReducer(this);
    _differenceReducer = new DifferenceReducer(this);
    _factorialReducer = new FactorialReducer(this);
    _fractionReducer = new FractionReducer(this);
    _numberReducer = new NumberReducer();
    _powerReducer = new PowerReducer(this);
    _productReducer = new ProductReducer(this);
    _sumReducer = new SumReducer(this);
    _tupleReducer = new TupleReducer(this);
    // other reducers
    _invokeReducer = new InvokeReducer(this, registry);
    _logicalReducer = new LogicalReducer();
    _objectReducer = new ObjectReducer(this);
    _relationalReducer = new RelationalReducer();
    _setReducer = new SetReducer(this);
  }

  /** Simplify expressions */
  Expr simplify(Expr expr) {
    var reduced = _simplifyRecursive(expr);
    if(!isNullary(reduced)) {
      // check for parentheses that are obsolete after simplification
      reduced = reduced.map((Expr e) {
        if(isTuple(e)) {
          return simplifyTuple(e);
        }
        return e;
      });
    }
    return reduced;
  }

  Expr _simplifyRecursive(Expr expr) {
    if(expr.reduced) {
      return expr;
    } else if(isNumber(expr)) {
      return simplifyNumber(expr);
    } else if(isAssign(expr)) {
      // TODO should we really return assignment statements ?, perhaps they ought 
      // to newer reach here (be replaced by a Nob expr in the resolver)
      return expr;
    } else if(isNullary(expr)) {
      return expr;
    } else if(_isHold(expr)) {
      return _hold(expr);
    } 

    // recursivly simplify the expressions operands
    expr = expr.map(_simplifyRecursive);

    // operators
    if(isAlgebraicOperator(expr)) {
      if(isDot(expr)) {
        return simplifyDot(expr);
      } else if(expr.anyOf([isDifference, isNegative])) {
        return simplifyDifference(expr);
      } else if(isFactorial(expr)) {
        return simplifyFactorial(expr);
      } else if(isFraction(expr)) {
        return simplifyFraction(expr);
      } else if(isPower(expr)) {
        return simplifyPower(expr);
      } else if(isProduct(expr)) {
        return simplifyProduct(expr);
      } else if(isSum(expr)) {
        return simplifySum(expr);
      }
    } else if(isLogicalOperator(expr)) {
      return simplifyLogical(expr);
    } else if(isRelationalOperator(expr)) {
      return simplifyRelational(expr);
    } else if(isSetOperator(expr)) {
      return simplifySet(expr);
    }

    // objects and functions
    if(isObject(expr) || isObjectOperator(expr)) {
      return simplifyObject(expr);
    } else if(isInvoke(expr)) {
      return simplifyInvoke(expr);
    }
    throw new ArgumentError('unhandled expression $expr ${isNegative(expr)}}');
  }

  // algebraic reducers
  Expr simplifyDifference(Expr expr) => _simplify('difference', expr, _differenceReducer);

  Expr simplifyDot(DotExpr expr) => _simplify('dot', expr, _dotReducer);

  Expr simplifyFactorial(FactorialExpr expr) => _simplify('factorial', expr, _factorialReducer);

  Expr simplifyFraction(FractionExpr expr) => _simplify('fraction', expr, _fractionReducer);

  Expr simplifyInvoke(InvokeExpr expr) => _simplify('invoke', expr, _invokeReducer);

  Expr simplifyNumber(Expr expr) => _simplify('number', expr, _numberReducer);

  Expr simplifyPower(PowerExpr expr) => _simplify('power', expr, _powerReducer);

  Expr simplifyProduct(ProductExpr expr) => _simplify('product', expr, _productReducer);

  Expr simplifySum(SumExpr expr) => _simplify('sum', expr, _sumReducer);

  Expr simplifyTuple(TupleExpr expr) => _simplify('tuple', expr, _tupleReducer);

  // other reducers
  Expr simplifyLogical(Expr expr) => _simplify('logical', expr, _logicalReducer);

  Expr simplifyObject(Expr expr) => _simplify('object', expr, _objectReducer);

  Expr simplifyRelational(Expr expr) => _simplify('relational', expr, _relationalReducer);

  Expr simplifySet(Expr expr) => _simplify('set', expr, _setReducer);

  /// simplify [expr] using [reducer] in a logging tracing context named [contextName]
  Expr _simplify(String contextName, Expr expr, Reducer reducer) => inContext(_logger, contextName, expr, reducer.reduce);

  bool _isHold(Expr expr) => (expr is InvokeExpr) ? (expr as InvokeExpr).name == 'hold' : false;
  
  // hold(1+2) = 1+2 
  Expr _hold(InvokeExpr expr) {
    if(expr.args.length != 1) {
      throw new ExprArgumentError('hold takes one argument', expr);
    }
    var body = expr.args[0];
    _logger.debug('holding ${body}');
    return body;
  }

  // algebraic reducers
  Reducer<DotExpr> _dotReducer;
  Reducer<Expr> _differenceReducer;
  Reducer<FactorialExpr> _factorialReducer;
  Reducer<FractionExpr> _fractionReducer;
  Reducer<Expr> _numberReducer;
  Reducer<PowerExpr> _powerReducer;
  Reducer<ProductExpr> _productReducer;
  Reducer<SumExpr> _sumReducer;
  Reducer<TupleExpr> _tupleReducer;
  // other reducers
  Reducer<Expr> _invokeReducer, _logicalReducer, _objectReducer, _relationalReducer, _setReducer;

  static AutomaticSimplifier _instance;
  static final _logger = LoggerFactory.getLoggerFor(AutomaticSimplifier);
}
