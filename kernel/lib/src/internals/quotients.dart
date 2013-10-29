// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

// TODO use lehmer's GCD algorithm for large inputs

/**
 * Gives a list of the quotient and remainder from division numerator/denominator.
 *
 * numerator = quotient * denominator + remainder
 */
List<Integer> divMod(Integer numerator, Integer denominator) {
  List<Integer> result = new List(2);
  Integer quotient = Integer.zero;
  if(numerator.isPositive && denominator.isPositive) {
    if(numerator > denominator) {
      // fx 10/4 => q = 2, r = 2
      var extender = Integer.one;
      while(true) {
        var limit = denominator * quotient;
        var diff = numerator - limit;
        if(diff < denominator) {
          break;
        } else if(numerator - (limit + (denominator * extender)) > denominator) {
          quotient += extender;
          extender += Integer.ten;
        } else {
          quotient += Integer.one;
          extender = Integer.one;
        }
      }
    } else if(numerator < denominator) {
      // fx. 4/10 => q = 4, r = 0
      quotient = Integer.zero;
    } else {
      // fx. 10/10 => q = 1, r = 0
      quotient = Integer.one;
    }
  } else if(numerator.isNegative && denominator.isNegative) {
    quotient = divMod(~numerator, ~denominator)[0];
  } else {
    // by now one number is positive and another negative
    if(numerator > denominator) {
      while(numerator > (quotient * denominator)) {
        quotient -= Integer.one;
      }
    } else {
      while(numerator < (quotient * denominator)) {
        quotient -= Integer.one;
      }
    }
  }

  result[0] = quotient;
  result[1] = numerator - (quotient * denominator);
  return result;
}

Integer div(Integer numerator, Integer denominator) {
  return divMod(numerator, denominator)[0];
}

Integer mod(Integer numerator, Integer denominator) {
  return divMod(numerator, denominator)[1];
}

/**
 * Returns the greatest common divisor
 *
 * fx. greatestCommonDevisor([8,12]) = 4 because
 * - devisors(8)  = 1, 2, 4, 8
 * - devisors(12) = 1, 2, 3, 4, 6, 12
 */
Integer greatestCommonDevisor(List<Integer> numbers) {
  if(numbers.length < 2) {
    throw new ArgumentError('GCD takes two arguments');
  }

  Integer gcd(Integer a, Integer b) {
    while(!b.isZero) {
      Integer r = mod(a,b);
      a = b;
      b = r;
    }
    return (a.isPositive) ? a : ~a;
  };
  return foldRight(tail(numbers), numbers[0], gcd);
}

/**
 * Returns the least common multiple
 *
 * fx. leastCommonMultiple([4,6]) = 12 because
 * - multiples(4) = 4,  8, 12, 16, ...
 * - multiples(6) = 6, 12, 18, 24, ...
 */
Integer leastCommonMultiple(List<Integer> numbers) {
  if(numbers.length < 2) {
    throw new ArgumentError('LCM takes two arguments');
  }

  Integer lcm(Integer a, Integer b) => div(a, greatestCommonDevisor([a,b])) * b;

  return foldRight(tail(numbers), numbers[0], lcm);
}
