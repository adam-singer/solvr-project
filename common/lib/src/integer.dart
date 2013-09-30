// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_common;

/**
 * Immutable arbitrary precision integer's
 * 
 * TODO this is a quick hack, figure out if Dart's int will become arbitrary precision on 
 * both VM and dart2js
 * 
 * TODO switch to bignum
 */
class Integer {
  /** Construct integer from a string */
  factory Integer(String integer) {
    notNullOrEmpty(integer);
    
    List<int> didgets = new List();
    bool negative = false;
   
    if(integer[0] == "-") {
      negative = true;
      integer = integer.substring(1);
    }
    integer = _removeLeadingZeros(integer);
    
    if(integer != "0") {
      var numRegex = new RegExp(r"(\d+)");
      var matches = numRegex.allMatches(integer);
      didgets = _numberToList(matches.first[0]);
    } else {
      didgets = [0];
    }
  
    return new Integer.fromDidgets(didgets, negative);
  }   
  
  /** Copy existing integer and optionally flip its sign */
  factory Integer.copy(Integer orig, bool negative) {
    return new Integer.fromDidgets(new List.from(orig.didgets), negative);
  }
  
  /** Construct integer from a Dart int */
  factory Integer.fromInt(int orig) {
    return new Integer(orig.toString());
  }
  
  /** Construct integer from a list of didgets */
  factory Integer.fromDidgets(List<int> _didgets, [bool negative = false]) {
    assert(step > 0);
    if(_didgets.length > 1 && _didgets.every((int i) => i == 0)) {
      // ensure zero is always represented the same way - UGLY! hack
      _didgets = [0];
    }
    final int _radix = Math.pow(10, step);
    return new Integer._internal(_didgets, negative, _radix);
  }
  
  Integer._internal(this.didgets, this._negative, this.radix);
  
  /** Common static values */
  static final minusOne = new Integer("-1");
  
  static final zero = new Integer("0");
  
  static final one = new Integer("1");
  
  static final two = new Integer("2");
  
  static final three = new Integer("3");
  
  static final four = new Integer("4");
  
  static final five = new Integer("5");
  
  static final six = new Integer("6");
  
  static final seven = new Integer("7");
  
  static final eight = new Integer("8");
  
  static final nine = new Integer("9");
  
  static final ten = new Integer("10");
  
  /** Addition */
  operator +(Integer other) {
    // -a + -b = -(a + b)
    if(isNegative && other.isNegative) return ~((~other) + (~this));
    // a + -b = a - b
    if(!isNegative && other.isNegative) return (this - (~other));
    // -a + b  = b - a
    if(isNegative && !other.isNegative) return (other - (~this));
    
    assert(this.isNegative == false && other.isNegative == false);
    Integer add(List<int> thisInts, List<int> otherInts) {
      final int overflow = radix - 1;
      List<int> result = [];
      int carry = 0;
      for(int i=0; i<thisInts.length; i++) {
        int sum = thisInts[i] + otherInts[i] + carry;
        if(sum > overflow) {
          carry = 1;
          result.add(sum - radix);
        } else {
          carry = 0;
          result.add(sum);
        }
      }
      if(carry > 0) {
        result.add(carry);
      }
      return new Integer.fromDidgets(result);
    }
    
    return _apply(other, add);
  }
  
  /** Increment */
  Integer get increment=> (this + one);
  
  /** Subtraction */
  operator -(Integer other) {
    // -a - -b = -(a - b) 
    if(isNegative && other.isNegative) return ~((~this) - (~other));
    // -a - b = -(a + b)
    if(isNegative && !other.isNegative) return (~((~this) + other));
    // a - -b = a + b
    if(!isNegative && other.isNegative) return (this + (~other));
    // (b > a) then a - b = - (b - a)
    if(this < other) return (~(other - this));
    
    // This subtraction algorithm only works when the current number is larger or
    // equal to the number subtracted from it. Other cases should be handled by 
    // the above rewriting 
    assert(this >= other);
    
    Integer subtract(List<int> thisInts, List<int> otherInts) {
      List<int> result = [];
      int borrow = 0;
      
      mapI(thisInts, (int elm, int i) {
        int difference = elm - (borrow + otherInts[i]);
        if(difference < 0) {
          result.add(difference + radix);
          borrow = 1;
        } else {
          result.add(difference);
          borrow = 0;
        }
      });
      return new Integer.fromDidgets(result, borrow != 0);
    };
    
    return _apply(other, subtract);
  }
  
  /** Decrement */
  Integer get decrement=> (this - one);
  
  /** Multiplication */
  operator *(Integer other) {
    // -a * b = -(a * b)
    if(isNegative && !other.isNegative) return ~((~this) * other);
    // a * -b = -(a * b)
    if(!isNegative && other.isNegative) return ~(this * (~other));
    // always multiply a smaller number by a larger
    if(this.abs > other.abs) return (other * this);
    
    Integer multiply(List<int> thisInts, List<int> otherInts) {
      Integer result = zero;
      var shifter = (int shifts) {
        String s = "";
        for(int i=0; i<shifts; i++) {
          s += "0";
        }
        return s;
      };
      
      mapI(thisInts, (int thisInt, int i) {
        mapI(otherInts, (int otherInt, int j) {
          var shift = shifter(j*step);
          int res = thisInt * otherInt;
          result += new Integer("${res}${shift}");
        });
      });
      return result;
    };
    return _apply(other, multiply);
  }
  
  /** Less than */ 
  operator <(Integer other) {
    // note we cannot use subtraction here since the subtraction operation relies on this operator
    if(this.isNegative && !other.isNegative) return true;
    if(!this.isNegative && other.isNegative) return false;

    bool bothNegative = this.isNegative && other.isNegative;
    bool lessThan = false;

    comparator(List<int> thisInts, List<int> otherInts) {
      for(int i=(thisInts.length - 1); i>=0; i--) {
        if(thisInts[i] < otherInts[i]) {
          lessThan = (bothNegative ? false : true);
          return null;
        }
        if(thisInts[i] > otherInts[i]) {
          lessThan =  (bothNegative ? true : false);
          return null;
        }
      }
      return null;
    }
    _apply(other, comparator);
   
    return lessThan;
  }
  
  /** Less than or equals */
  operator <=(Integer other) {
    return (this < other || this == other);
  }
  
  /** Greater than */
  operator >(Integer other) {
    return !(this <= other);
  }
  
  /** Greater than or equals */
  operator >=(Integer other) {
    return (this > other || this == other);
  }
  
  /** Equals */
  operator ==(Integer other) {
    if(didgets.length != other.didgets.length) return false;
    bool equals = true;
    mapI(didgets, (e, i) {
      if(e != other.didgets[i]) {
        equals = false;
        return;
      }
    });
    return equals;
  }
  
  /** Negatation */
  operator ~() {
    return new Integer.copy(this, !isNegative);
  }
  
  /** Absolute value */
  Integer get abs {
    if(isNegative) {
      return (~this);
    }
    return new Integer.copy(this, isNegative);
  }
  
  /** Power */
  Integer pow(Integer exponent) {
    if(exponent > zero) {
      return this * this.pow(exponent - one);
    } else if(exponent == zero) {
      return one;
    } else if(exponent < zero) {
      throw new ArgumentError("integers cannot have negative exponents, use rational numbers instead");
    } 
  }
  
  /** Attempt to convert to Dart int, may fail if value is to big */
  int get asInt => int.parse(toString());
  
  /** Get number of didgets in integer */
  int get length => toString().length;
  
  /** Common value checks */
  bool get isNegative => _negative;
  
  bool get isZero => (didgets.length == 1 && didgets[0] == 0);
    
  bool get isOne => (_asOne && isPositive);
  
  bool get isMinusOne => (_asOne && isNegative);
  
  bool get isPositive => this > zero;  
  
  bool get _asOne => didgets.length == 1 && didgets[0] == 1;
  
  String toString() {
    String makeString(List<int> numbers) {
      String res = "";
      mapI(numbers, (int elm, int i) {
        String val = "${elm * Math.pow(radix, i)}";
        final int offset = i * step;
        
        if(val.length - offset > 0) {
          val = val.substring(0, (val.length - offset));
        }
        while(val.length < step) {
          val = "0$val";
        }
        res = val + res;
      });
      return res;
    }
    
    String prettyNum = (didgets.length == 0) ? "0" : _removeLeadingZeros(makeString(didgets));
    if(_negative) prettyNum = "-${prettyNum}";
    
    return prettyNum;
  }
  
  // Apply evaluator to a equal length's copies of the didgets in this and other number
  Integer _apply(Integer other, _EvalIntegers evaluator) {
    var thisDidgets = new List.from(didgets);
    var otherDidgets = new List.from(other.didgets);
    
    zeroExtend(List<int> list, int extend) => list.insertAll(list.length, new List.filled(extend, 0));
    makeListEqualLength(List<int> a1, List<int> a2, balancer) {
      if(a1.length > a2.length) {
        balancer(a2, (a1.length - a2.length));
      } else if(a1.length < a2.length) {
        balancer(a1, (a2.length - a1.length));
      }
      if(a1.length != a2.length) {
        throw new ArgumentError("list ${a1} is not same length as ${a2}");
      }
    }
    
    // make equal length whole numbers 100 + 1 = 100 + 001
    makeListEqualLength(thisDidgets, otherDidgets, zeroExtend);
    
    return evaluator(thisDidgets, otherDidgets);
  }
  
  // Make number into a list indexed from zero using step to controls the size of the 
  // arrays backing the number, for example:
  //
  // - step = 1 => 102 = [2, 0, 1] (2*10^0 + 0*10^1 + 1*10^2)
  // - step = 2 => 102 = [2, 1] (2*100^0 + 1*100^1)
  static List<int> _numberToList(String number) {
    List<String> list = [];
    if(step >= number.length) {
      list.add(number);
    } else {
      for(int i=(number.length - 1); i>=0; i -= step) {
        if((i-step) < 0) {
          list.add( number.substring(0,i+1) );
        } else {
          list.add( number.substring(i-(step-1),i+1) );
        }
      }
    }
    return new List<int>.from(list.map((s) => int.parse(s)));
  }
  
  static String _removeLeadingZeros(String integer) {
    while(integer != "0" && integer[0] == "0") {
      integer = integer.substring(1);
    }
    return integer;
  }
  
  /**
   * [step] controls the size of the integers used internally to do the calculations 
   * it cannot be smaller than one but should for ideal performance be alligned with 
   * the maximum size of integers handled correctly by Dart
   * 
   * TODO the word usage here is messed up after the refac [step] is really the exponent 
   * and [radix] is just helper for calculating base^exponent
   */
  static int step = 6;
  final List<int> didgets;
  final int radix;
  final bool _negative;
}

typedef Integer _EvalIntegers(List<int> thisWholePart, List<int> otherWholePart);
