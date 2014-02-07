// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_kernel_math_functions_combinatorics;

 // factorial power
Integer fallingPower(Integer x, Integer n, Integer h) {
  // x(x-h) …. (x - (n-1)h)

  // min x(x-h)
  // max x(x - n + h)

  // productOf(x(x - n + h), n in 0..nVal, h = hVal,

  // from n in 0...n
  /*
  var res = Integer.one;
  while(n.isPositive) {
  }
    var res = Integer.one;
    for ( i = 0; i < p; i++) res *= n--;
    return t;
  }
  */
}


Integer binomialCoeff(Integer n, Integer k) {
    /*
  {
      if ((k < 0) || (k > n)) return 0;
      k = (k > n / 2) ? n - k : k;
      return fallingPower(n, k) / factorial(k);
  }

   var nFact = factorial(n);
        var k = asNumber(index);
        var kFact = factorial(k);
        var n_minus_k = n - k;
        var binom = nFact/(kFact * factorial(n_minus_k));

        var tmp1 = binom * power(first, n_minus_k);
        var tmp2 = _expandPower(rest, k);
        var tmp3 = _expandProduct(tmp1, tmp2);
  */
}
