// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Reduce products */
class ProductReducer extends Reducer<ProductExpr> {
  ProductReducer(this._simplifier); 

  Expr reduce(ProductExpr expr) {
    var operands = expr.operands;
    _logger.debug("operands for $expr are $operands");

    // 0 * x, 12 * 0, .. = 0
    if(operands.any(isZero)) {
      return zero;
    }

    List<Expr> res = _reduceProducts(operands);
    return productOf(res);
  }

  /*
   * Convert binary products into a ordered n-ary product list.
   *
   * for example c*b*c = ProdExpr(c, ProdExpr(b,c)) becomes [b,c^2].
   *
   * Returns empty list when product simplified to one (fx. 1/x * x)
   */
  List<Expr> _reduceProducts(List<Expr> args) {
    _logger.debug("reducing product ${args}");
    assert(args.length > 1);

    Expr u1 = args[0];
    Expr u2 = args[1];

    if(args.length > 2) {
      // x * y * (x+2) * z^2 = [x,y,x+2,x^2] = x * reduceProducts([y,x+2,z^2])
      List<Expr> w = _reduceProducts(tail(args));
      if(isProduct(u1)) {
        return _mergeProducts(u1.operands, w);
      }
      return _mergeProducts([u1], w);
    }

    if(isProduct(u1) && isProduct(u2)) {
      // (a*b) * (c*d)
      return _mergeProducts(u1.operands, u2.operands);
    } else if(isProduct(u1) && !isProduct(u2)) {
      // (a*b) * (c+d)
      return _mergeProducts(u1.operands, [u2]);
    } else if(!isProduct(u1) && isProduct(u2)) {
      // (a+b) * (c*d)
      return _mergeProducts([u1], u2.operands);
    } else if(!isProduct(u1) && !isProduct(u2)) {
      _logger.debug("handling product $u1 and $u2");

      // 2 * 3, ...
      if(isNumber(u1) && isNumber(u2)) {
        NumberExpr n = _simplifier.simplifyNumber(u1 * u2);
        return isOne(n) ? [] : [n];
      }

      // 1 * x = x
      if(isOne(u1)) {
        return [ u2 ];
      }
      // x * 1 = x
      if(isOne(u2)) {
        return [ u1 ];
      }

      // vectors, matrix, list, set, ...
      if([u1, u2].any(isAlgebraicCollection)) {
        var first = isInOrder(u1, u2) ? u1 : u2;
        var second = (identical(first, u1)) ? u2 : u1;
        return _reduceCollectionProduct(first, second);
      }

      // x * x = x^2 and x^2 * x^3 = x^5, ...
      if(baseOf(u1) == baseOf(u2)) {
        var exp = exponentOf(u1) + exponentOf(u2);
        exp = _simplifier.simplifySum(exp);
        Expr p = _simplifier.simplifyPower( asPower(baseOf(u1), exp) );
        // check for cases such as x^(-1) * x = x^(-1+1) = x^0 = 1
        return isOne(p) ? [] : [p];
      }

      // y * x = x * y
      if(!isInOrder(u1, u2)) {
        return [u2, u1];
      }

      // x * y = x * y
      return [u1, u2];
    }
  }

  List<Expr> _reduceCollectionProduct(var u1, var u2) {
    _logger.debug("handling collection product of $u1 and $u2");
    if(isAlgebraicCollection(u1) && isAlgebraicCollection(u2)) {
      if(u1.length == u2.length) {
        var multiplied = u1.mapThisI((Expr operand, int i) => reduce(operand * u2[i]));
        return [ multiplied ];
      }
    } else {
      if(isTuple(u2) && u2.length == 1) {
        // 2(x+y) = 2x + 2y... is not part automatic simplification so just return it
        return [u1, u2];
      }
      var multiplied = u2.map((Expr e) => reduce(u1 * e));
      return [ multiplied ];
    }
    return [u1, u2];
  }

  /*
   * Reorder operands in products such as (a*c) * (b*a) so equal terms, like a*a, are reduced to a^2
   * this is done by sorting the lists [a,b] and [c,a] into [a,a], [b,c] which is merged into [a^2,b,c]
   */
  List<Expr> _mergeProducts(List<Expr> p, List<Expr> q) {
    if(q.isEmpty) return p;
    if(p.isEmpty) return q;

    var p1 = p[0];
    var q1 = q[0];

    var h = _reduceProducts( [p1, q1] );
    // p1 * q1 simplified to 1
    if(h.isEmpty) {
      return _mergeProducts(tail(p), tail(q));
    }
    var res = <Expr>[];
    // p1 * q1 combined to a new operand (fx. x * x^2 = x^3).
    if(h.length == 1) {
      res.addAll(h);
      res.addAll( _mergeProducts(tail(p),tail(q)) );
      return res;
    }
    // p1 * q1 was not reordered
    if(h[0] == p1 && h[1] == q1) {
      res.add(p1);
      res.addAll( _mergeProducts(tail(p), q) );
      return res;
    }
    // p1 * q1 was reordered
    if(h[0] == q1 && h[1] == p1) {
      res.add(q1);
      res.addAll( _mergeProducts(p, tail(q)) );
      return res;
    }

    throw new KernelError("unhandled merge product structure ${h} for p1: $p1 and q1: $q1");
  }
  
  final AutomaticSimplifier _simplifier;
  static final Logger _logger = LoggerFactory.getLoggerFor(ProductReducer);
}

