// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_functions_number_theory;

/**
 * Get the absolute value of a number or function
 *
 * TODO extend abs to also work on complex numbers
 */
Expr abs(var expr) {
  var clone = expr.clone;
  return _abs(clone);
}

Expr _abs(var expr) {
  if(isNumber(expr)) {
    return (isNegativeNumber(expr)) ? _negate(expr) : expr;
  } else if(isPower(expr)) {
    var base = baseOf(expr);
    var exponent = exponentOf(expr);
    if(isPositiveInteger(exponent)) {
      return asPower(_abs(base), exponent);
    } else if(isNegativeInteger(exponent)) {
      var denom = asPower(_abs(base), _negate(exponent));
      return one/denom;
    }
  } else if(isProduct(expr)) {
    var operands = expr.operands;
    var values = expr.operands.map(_abs);
    return new ProductExpr(values);
  }
  return asInvoke("abs", asTuple(expr));
}

NumberExpr _negate(var expr) => ~expr;

/**
 * Convert number into decimal
 */
Expr decimalize(NumberExpr number) {
  Expr res = _decimalize(number);
  res.reduced = true;
  return res;
}

Expr _decimalize(NumberExpr number) {
  // TODO in module function also handle pi, e...
  if(isInteger(number)) {
    return number;
  } else if(_canTerminate(number)) {
    // 1/2 =
    // a) s = 10, d = 2, i =1
    //  - mod(10,2) == 0
    // b) 10/2 == 5
    // c) t = 1 * 5 = 5
    // d) t = 5, s = 10, i = 1, r=0.5

    // 3/4 =
    // a) s = 10, d = 4, i =1
    //  - mod(10,4) == 2
    //  - s = 100, i = 2
    //  - mod(100,4) == 0
    // b) 100/4 == 25
    // c) t = 3 * 25 = 75
    // d) t = 75, s = 100, i = 2, r=0.75

    // 5/4 =
    // a) s = 10, d = 4, i=1
    //  - mod(10,4) == 2
    //  - s = 100, i = 2
    //  - mod(100,4) == 0
    // b) 100/4 == 25
    // c) t = 5 * 25 = 125
    // d) t = 125, s = 100, i = 2, r=1.25

    Integer scaler = Integer.ten;
    Integer steps = Integer.one;
    while(scaler < number.denominator || mod(scaler, number.denominator) != Integer.zero) {
      steps = steps.increment;
      scaler = Integer.ten.pow(steps);
    }
    var scale = div(scaler, number.denominator);
    var res = "${number.numerator * scale}";
    var offset = res.length - steps.asInt;

    String wholePart = "";
    String decimalPart = "";
    if(offset <= 0) {
      wholePart = "0";
      while(offset < 0) {
        decimalPart = "0$decimalPart";
        offset += 1;
      }
      decimalPart = "${decimalPart}${res.substring(0,steps.asInt)}";
    } else {
      wholePart = res.substring(0,steps.asInt-1);
      decimalPart = res.substring(steps.asInt-1);
    }
    return new NumberExpr.real("${wholePart}.${decimalPart}");
  } else {

    /*
     * Turn non terminating number into one that can terminate
     *
     * a/b = a * (1/b) where
     *
     * 1/b ~ ((10^x - 1)/b)/10^x where x is a number above 6 where mod(10^x - 1, b) == 0
     */
    final Integer minSteps = Integer.six;
    final Integer maxSteps = Integer.ten;
    Integer step = Integer.zero;
    Integer pow, scaled;
    List<Integer> dm;

    while(step < maxSteps) {
      step = step.increment;
      pow = Integer.ten.pow(step);
      scaled = pow - Integer.one;

      dm = divMod(scaled, number.denominator);
      if(dm[1].isZero) {
        if(step >= minSteps) {
          break;
        }
      }
    }

    String wholePart, decimalPart ;
    if(!number.numerator.isOne) {
      var res = "${dm[0] * number.numerator}";
      var offset = res.length - (dm[0]).length;
      if(offset > 0) {
        wholePart = res.substring(0,offset);
        decimalPart = res.substring(offset-1);
      } else {
        wholePart = "0";
        decimalPart = res;
      }
    } else {
      wholePart = "0";
      decimalPart = "${dm[0]}";
    }
    return asReal("$wholePart.$decimalPart");
  }
}

/**
 * Determine if a fraction can terminate
 *
 * Note a fraction will terminate if and only if the denominator has for prime divisors only 2 and 5 since
 * every terminating decimal has the form n/10^e, for some e >= 0 since n/10^e = n/(2*5)^e = n/(2^e*5^e)
 */
bool _canTerminate(NumberExpr number) {
  if(isInteger(number)) {
    return true;
  } else {
    return mod(number.denominator, Integer.two).isZero || mod(number.denominator, Integer.five).isZero;
  }
}

/**
 * Return the maximum expression from a list of comparable expressions.
 * We define two expressions f and g to be comparable if f - g is a
 * numerical value
 */
Expr max(List<Expr> list) {
  // TODO allow access to simplify
  // TODO see page 196 in elementary CAS algo book
}

/**
 * Get n-th root using newton's method on [Interger]
 *
 * fx. 37^(1/5) is the same as trying to solve x^5 - 37 = 0.
 */
Integer nthRoot(Integer number, Integer root) {
  // Integer implementation.
  Integer step(Integer r, Integer n, Integer x) => div(((r-Integer.one)*x + div(n,x.pow(r-Integer.one))),r);

  _nthRootAsInteger(r,n) {
    Integer x = Integer.one, y = step(r,n,x);
    do {
        x = y;
        y = step(r,n,x);
    } while(y < x);

    return x;
  }

  /*
  RationalNumber _nthRootAsRationalNumberSimple(Integer n, RationalNumber x) {
    var exponent = (new RationalNumber.integer(Integer.one) / new RationalNumber.integer(n));
    return x.pow(exponent);
  }

  print(_nthRootAsRationalNumberSimple(number, new RationalNumber.integer(root)));
  */

  return _nthRootAsInteger(root, number);

  /*
   * Untested, use when we decide to take roots of rational numbers
  RationalNumber _nthRootAsRationalNumber(Integer n, RationalNumber x) {
    var _min = new RationalNumber.integer(Integer.zero);
    var _max = RationalNumber.one > x ? RationalNumber.one : x;
    for (int i = 0; i < 100; i++) {
      RationalNumber mid = (_min + _max) / 2;
      RationalNumber midpow = RationalNumber.one;
      for (Integer j = Integer.zero; j < n; j.increment) {
        midpow *= mid;
      }

      if (midpow > x) {
        _max = mid;
      } else {
        _min = mid;
      }
    }

    var two = new RationalNumber.integer(Integer.two);
    return (_min+_max)/two;
  }
  */

  /*
   * This implementation became very computationally expensive quickly.
   * Future implementations to handle rational numbers will be implemented.
   * http://en.wikipedia.org/wiki/Shifting_nth-root_algorithm
   * http://en.wikipedia.org/wiki/Exponentiation_by_squaring
   * http://rosettacode.org/wiki/Nth_root
   * http://en.wikipedia.org/wiki/Nth_root_algorithm
   * http://mathforum.org/library/drmath/view/52632.html
   * Binary Search: http://goo.gl/XDZoR
   * 4 methods on nth-root http://goo.gl/99p7E
  var precision = new RationalNumber(Integer.one, Integer.ten * Integer.ten * Integer.ten); //.001;
  List<RationalNumber> x = new List(2);
  var __number = new RationalNumber.integer(number);
  var __root = new RationalNumber.integer(root);
  x[0] = __number;
  x[1] = __number/__root;
  while ((x[1] - x[0]).abs > precision) {
    x[0] = x[1];

    var ___n1 = ((__root - RationalNumber.one)*x[1]);
    var ___n2 = x[1].pow(__root - RationalNumber.one);
    x[1] = (___n1 + __number /  ___n2)/ __root;
  }

  return x[1];
  */
}

/**
 * Primality test of [Integer] [n].
 */
bool isPrime(Integer n) {
  // TODO: Implementation is naive until sqrt is implemented
  /*
  if(n < Integer.two) {
    return false;
  }
  var i = Integer.two;
  var m = sqrt(n); // TODO: implement sqrt
  while(i<=m) {
    if(isZero(div(n,i)) {
      return true;
    }
    i.increment;
  }
  return false;
  */

  if(n < Integer.two) {
    return false;
  } else if (n == Integer.two) {
    return true;
  }

  if (mod(n, Integer.two) == Integer.zero) {
    return false;
  }

  for (var i = Integer.three; i*i <= n; i+=Integer.two) {
    if (mod(n, i) == Integer.zero) return false;
  }

  return true;
}

Integer primeNumber(Integer n) {
  // This implementation is Sieve of Eratosthenes with limit up to 1000.
  // Later implementations should not be computationally expensive, instead
  // use a look up table.
  // Good source of prime number list http://primes.utm.edu/lists/small/100000.txt

  // TODO: Negative n not allowed. Requesting the prime above 999, not allowed.

  //final limit = 1000;
  final limit = 10000;
  final sieve = new Set<int>();

  for(int i = 2; i <= limit; i++) {
    sieve.add(i);
  }

  for(int i = 2; i * i <= limit; i++) {
    if(sieve.contains(i)) {
      for(int j = i * i; j <= limit; j += i) {
        sieve.remove(j);
      }
    }
  }

  final sortedValues = new List<int>.from(sieve);
  sortedValues.sort((int arg1, int arg2) {
    return arg1.compareTo(arg2);
  });

  return new Integer.fromInt(sortedValues[n.asInt]);
}

Function _fibstepseq(var start) {
  var addnum = start.length;
  var memory = start;
  fib (var n) {
    try {
      return memory[n];
    } on RangeError catch (ex) {
      var s = 0;
      for (var i = n - addnum; i < n; i++) {
        s += fib(i);
      }
      memory.add(s);
      return s;
    }
  }

  return fib;
}

Integer nacciSequence(var n, var name) {
  // TODO: final const naccis
  Map naccis = {"fibo":[0, 1],
                "tribo":[0, 0, 1],
                "tetra":[0, 0, 0, 1],
                "penta":[0, 0, 0, 0, 1],
                "hexa":[0, 0, 0, 0, 0, 1],
                "hepta":[1, 1, 2, 4, 8, 16, 32],
                "octo":[1, 1, 2, 4, 8, 16, 32, 64],
                "nona":[1, 1, 2, 4, 8, 16, 32, 64, 128],
                "deca":[1, 1, 2, 4, 8, 16, 32, 64, 128, 256]};

  var f = _fibstepseq(naccis[name]);
  Integer i = new Integer.fromInt(f(n.asInt));
  return i;
}

/**
 * Convert number into fraction
 */
NumberExpr rationalize(var expr) {
  if(isNumber(expr)) {
    if(!expr.isReal) {
      return expr;
    } else {
      // since all numbers in Solvr are represented as fractions
      // just throw away the information that the number was
      // a real to ensure its rendered as a fraction
      return new NumberExpr(expr.numerator, expr.denominator);
    }
  } else if(isSymbol(expr)) {
    if(isEuler(expr) || isImaginary(expr) || isPi(expr)) {
      throw new ArgumentError("cannot rationalize $expr");
    }
    return expr;
  }
}

Logger get _logger => LoggerFactory.getLogger("function.NumberTheory");



