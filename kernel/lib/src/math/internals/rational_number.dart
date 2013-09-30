// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

class RationalNumber {
  RationalNumber(this.numerator, this.denominator);

  RationalNumber.integer(Integer value): this(value, Integer.one);

  static RationalNumber get zero => new RationalNumber.integer(Integer.zero);

  static RationalNumber get one => new RationalNumber.integer(Integer.one);

  operator *(RationalNumber other) {
    return new RationalNumber(numerator * other.numerator, denominator * other.denominator);
  }

  operator /(RationalNumber other) {
    return new RationalNumber(numerator * other.denominator, denominator * other.numerator);
  }

  operator +(RationalNumber other) {
    return _onNormalized(this, other, (x,y) => x + y);
  }

  operator -(RationalNumber other) {
    return _onNormalized(this, other, (x,y) => x - y);
  }

  operator ~() {
    return new RationalNumber(~numerator, denominator);
  }

  operator ==(RationalNumber other) {
    return (other.numerator == numerator && other.denominator == denominator);
  }

  operator >(RationalNumber other) {
    return (numerator * other.denominator > other.numerator * denominator);
  }

  operator >=(RationalNumber other) {
    return (numerator * other.denominator >= other.numerator * denominator);
  }

  operator <(RationalNumber other) {
    return (numerator * other.denominator < other.numerator * denominator);
  }

  operator <=(RationalNumber other) {
    return (numerator * other.denominator <= other.numerator * denominator);
  }

  // TODO make pow function handle fractions in exponent
  RationalNumber pow(RationalNumber exponent) {
    if(numerator.isZero) {
      throw new ArgumentError();
    }

    if(exponent > zero) {
      return this * this.pow(exponent - one);
    } else if(exponent == zero) {
      return one;
    } else if(exponent < zero) {
      return (one / (this.pow(~exponent)));
    }
  }

  bool get isInteger => denominator.isOne || denominator.isMinusOne;

  Integer get asInteger {
    if(!isInteger) {
      throw new StateError('rational number is not an integer');
    }
    return numerator;
  }

  /** calculate factorial. Throws exception if number is not a positive integer */
  RationalNumber get fact {
    if(!isInteger || this < zero) {
      throw new UnsupportedError("factorial is only defined for positive Integers");
    }
    if(this == zero || this == one) {
      return one;
    }
    return this * (this - one).fact;
  }

  /** Get the absolute value */
  RationalNumber get abs => (this < zero) ? ~this : this;

  /** Reduce number to lowest terms */
  RationalNumber get reducedForm {
    if(isInteger) {
      return this;
    }

    List<Integer> qr = divMod(numerator, denominator);
    if(qr[1].isZero) {
      return new RationalNumber.integer(qr[0]);
    } else {
      Integer gcd = greatestCommonDevisor([numerator, denominator]);
      if(denominator.isPositive) {
        return new RationalNumber(div(numerator, gcd), div(denominator, gcd));
      } else {
        return new RationalNumber(div(~numerator, gcd), div(~denominator, gcd));
      }
    }
  }

  String toString() => "${numerator}/${denominator}";

  // execute function on normalized denominators
  RationalNumber _onNormalized(RationalNumber n1, RationalNumber n2, Integer func(Integer x, Integer y)) {
    if(n1.isInteger && n2.isInteger) {
      return new RationalNumber.integer(func(n1.numerator, n2.numerator));
    }
    var numbers = _normalizeDenominators([n1, n2]);
    return new RationalNumber(func(numbers.first.numerator, numbers.last.numerator), numbers.first.denominator);
  }

  // put all numbers on same denominator
  Iterable<RationalNumber> _normalizeDenominators(Iterable<RationalNumber> numbers) {
    var lcm = leastCommonMultiple(numbers.map((n) => n.denominator).toList());
    var result = numbers.map((n) {
      var scale = div(lcm, n.denominator);
      return new RationalNumber(scale * n.numerator, scale * n.denominator);
    });
    return result;
  }
  
  final Integer numerator;
  final Integer denominator;
}
