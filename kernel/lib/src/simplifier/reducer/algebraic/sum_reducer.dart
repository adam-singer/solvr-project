// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_simplifier;

/** Reduce sums */
class SumReducer extends Reducer<SumExpr> {
  SumReducer(this._simplifier);

  Expr reduce(SumExpr expr) {
    List<Expr> res = _reduceSums(expr.operands);
    return sumOf(res);
  }

  /*
   * Convert binary sums into a ordered n-ary sum list.
   *
   * for example a+b+a = SumExpr(a, SumExpr(b,a)) becomes [2a,b].
   *
   * Returns empty list when sum simplified to zero (fx. 2x + -2x)
   */
  List<Expr> _reduceSums(List<Expr> args) {
    _logger.debug('reducing sum ${args}');
    assert(args.length > 1);

    var u1 = args[0];
    var u2 = args[1];

    if(args.length > 2) {
      // x + y + (x*2) + z^2 = [x,y,x*2,x^2] = x + reduceSums([y,x*2,z^2])
      List<Expr> w = _reduceSums(tail(args));
      if(isSum(u1)) {
        return _mergeSums(u1.operands, w);
      }
      return _mergeSums([u1], w);
    }

    if(isSum(u1) && isSum(u2)) {
      // (a+b) + (c+d)
      return _mergeSums(u1.operands, u2.operands);
    } else if(isSum(u1) && !isSum(u2)) {
      // (a+b) + (c*d)
      return _mergeSums(u1.operands, [u2]);
    } else if(!isSum(u1) && isSum(u2)) {
      // (a+b) + (c*d)
      return _mergeSums([u1], u2.operands);
    } else if(!isSum(u1) && !isSum(u2)) {
      _logger.debug('handling sum $u1 and $u2');

      // 2 + 3, ...
      if(isNumber(u1) && isNumber(u2)) {
        NumberExpr res = _simplifier.simplifyNumber(u1 + u2);
        return isZero(res) ? [] : [res];
      }

      // x + x = 2x, x^2 + x^2 = 2*x^2
      if(u1 == u2) {
        Expr res = _simplifier.simplifyProduct(two * u1);
        return isZero(res) ? [] : [res];
      }

      // 0 + x = x
      if(isZero(u1)) {
        return [ u2 ];
      }
      // x + 0 = x
      if(isZero(u2)) {
        return [ u1 ];
      }

      // vectors, matrix, list, set, ...
      if([u1, u2].any(isAlgebraicCollection)) {
        return _reduceAlgebraicCollections(u1, u2);
      }

      // x + 2*x = 1*x + 2*x
      Expr p1 = isProduct(u1) ? _simplifier.simplifyProduct(u1) : one * u1;
      // 2*x + x = 2*x + 1*x
      Expr p2 = isProduct(u2) ? _simplifier.simplifyProduct(u2) : one * u2;

      var p1Nums = p1.operands.where(isNumber).toList();
      var p2Nums = p2.operands.where(isNumber).toList();
      var p1Exprs = p1.operands.where(isNotNumber).toList();
      var p2Exprs = p2.operands.where(isNotNumber).toList();

      if(p1Exprs.length == p2Exprs.length && hasSameElements(p1Exprs, p2Exprs)) {
        // 2*x - 3*x = (2 + (-1 * 3)) * x
        var p1NumsMult = _simplifyProductOf(p1Nums) as NumberExpr;
        var p2NumsMult = _simplifyProductOf(p2Nums) as NumberExpr;
        var numsSum = _simplifier.simplifyNumber(p1NumsMult + p2NumsMult);
        Expr res = _simplifyProductOf(p1Exprs..add(numsSum));
        return isZero(res) ? [] : [res];
      }

      // y + x = x + y
      if(!isInOrder(u1, u2)) {
        return [u2, u1];
      }

      // x + y = x + y
      return [u1, u2];
    }
  }

  Expr _simplifyProductOf(List<Expr> operands) {
    var res = productOf(operands);
    if(isProduct(res)) {
      return _simplifier.simplifyProduct(res);
    }
    return res;
  }

  /** Reduce sum involving one or more algebraic collections. */
  List<Expr> _reduceAlgebraicCollections(Expr u1, Expr u2) {
    _logger.debug('handling sums containing algebraic collections $u1 and $u2');

    var col1 = isCollection(u1) ? u1 as CollectionExpr : null;
    var col2 = isCollection(u2) ? u2 as CollectionExpr : null;
    if(col1 == null && col2 != null) {
      return _reduceAlgebraicCollectionSum(u1, col2);
    } else if(col1 != null && col2 == null) {
      return _reduceAlgebraicCollectionSum(u2, col1);
    } else  {
      if(col1.hasSameType(col2) && col1.hasSameDimension(col2)) {
        // sum is only defined for collections that has the same dimension
        var added = col1.mapThisI((Expr operand, int i) => reduce(operand + col2[i]));
        return [ added ];
      }
    }
    return [u1, u2];
  }

  /** Reduce a sum of a expression [expr] and a algebraic collection [col] */
  List<Expr> _reduceAlgebraicCollectionSum(Expr expr, CollectionExpr collection) {
    // TODO figure out if this tuple check is really needed
    if(isTuple(collection)) {
      var res = _simplifier.simplifyTuple(collection);
      if(!identical(res, collection)) {
        return [expr, res];
      }
      return [expr, collection];
    }
    // 2 + [3, 5] = [5, 7]
    var added = collection.map((Expr e) => reduce(expr + e));
    return [ added ];
  }

  /*
   * Reorder operands in sums such as (a+c) + (b+a) so equal terms, like a+a, are reduced to 2*a
   * this is done by sorting the lists [a,b] and [c,a] into [a,a], [b,c] which is merged into [2*a,b,c]
   */
  List<Expr> _mergeSums(List<Expr> p, List<Expr> q) {
    if(q.isEmpty) {
      return p;
    }
    if(p.isEmpty) {
      return q;
    }

    var p1 = p[0];
    var q1 = q[0];

    List<Expr> h = _reduceSums( [p1, q1] );
    // p1 + q1 simplified to 1
    if(h.isEmpty) {
      return _mergeSums(tail(p), tail(q));
    }
    List<Expr> res = [];
    // p1 + q1 combined to a new operand (fx. x + x = 2*x).
    if(h.length == 1) {
      res.addAll(h);
      res.addAll( _mergeSums(tail(p),tail(q)) );
      return res;
    }
    // p1 + q1 was not reordered
    if(h[0] == p1 && h[1] == q1) {
      res.add(p1);
      res.addAll( _mergeSums(tail(p), q) );
      return res;
    }
    // p1 + q1 was reordered
    if(h[0] == q1 && h[1] == p1) {
      res.add(q1);
      res.addAll( _mergeSums(p, tail(q)) );
      return res;
    }

    throw new KernelError('unhandled sum merge structure ${h} for p1: $p1 and q1: $q1');
  }

  final AutomaticSimplifier _simplifier;
  static final _logger = LoggerFactory.getLoggerFor(SumReducer);
}

