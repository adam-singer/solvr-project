// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represent integer or reals as rational numbers (i.e. 2.11 = 211/100) */
class NumberExpr extends NullaryExpr<String> {
  factory NumberExpr(Integer numerator, Integer denominator) {
    if(denominator.isNegative) {
      numerator = ~numerator;
      denominator = ~denominator;
    }

    String val;
    if(denominator.isOne) {
      val = "$numerator";
    } else {
      val = "${numerator}/${denominator}";
    }
    return new NumberExpr._internal(numerator, denominator, val, false);
  }

  factory NumberExpr.integer(Integer value) {
    return new NumberExpr(value, Integer.one);
  }

  factory NumberExpr.real(String str) {
    List<String> parts = str.split(r".");
    assert(parts.length == 2);

    final String wholeStr = parts[0];
    final String decimalStr = parts[1];
    if(decimalStr.isEmpty || containsOnly(decimalStr, "0")) {
      return new NumberExpr.integer(new Integer(wholeStr));
    }

    Integer scaled = new Integer("${wholeStr}${decimalStr}");
    String div = "1";
    while(div.length <= decimalStr.length) {
      div = "${div}0";
    }
    Integer divisor = new Integer(div);

    return new NumberExpr.realFromRational(scaled, divisor, str);
  }

  factory NumberExpr.realFromRational(Integer numerator, Integer denominator, String value) {
    return new NumberExpr._internal(numerator, denominator, value, true);
  }

  NumberExpr._internal(this.numerator, this.denominator, String value, this.isReal): super(value, ObjectTypes.NUMBER) {
    if(denominator == Integer.zero) {
      throw new ExprUndefinedError("division by zero", this);
    }
    if(denominator.isNegative != false) {
      throw new ExprArgumentError("negative numbers must be represented using a negative numerator", this);
    }
  }

  Expr get clone => isReal ? asReal(value) : new NumberExpr(numerator, denominator);

  operator ~() {
    if(isReal) {
      var newValue = numerator.isNegative ? value.substring(1) : "-"+(value);
      return new NumberExpr.realFromRational(~numerator, denominator, newValue);
    } else {
      return new NumberExpr(~numerator, denominator);
    }
  }

  final Integer numerator;
  final Integer denominator;
  final bool isReal;
}

NumberExpr asNumber(var value) {
  if(value is String) {
    return new NumberExpr.integer(new Integer(value));
  } else if(value is Integer) {
    return new NumberExpr.integer(value);
  } else if(value is int) {
    return new NumberExpr.integer(new Integer.fromInt(value));
  } else if(value is NumberExpr) {
    return value;
  }
  throw new ArgumentError("cannot convert $value to Number");
}

NumberExpr asReal(String value) => new NumberExpr.real(value);
