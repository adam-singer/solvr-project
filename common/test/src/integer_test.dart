// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_common_test;

class IntegerTest {
  IntegerTest() {
    group("Integer internal structure", () {
      assertStructure(String number, List<int> expectedDidgets, int step, [bool negative = false]) {
        Integer.step = step;
        Integer integer = new Integer(number);
        
        expect(number, equals(integer.toString()));
        expect(integer.didgets.length, equals(expectedDidgets.length));
        expect(negative, equals(integer.isNegative));
        mapI(expectedDidgets, (didget, index) => expect(didget, equals(integer.didgets[index])));
      }
      
      test("size 1", () {
        assertStructure("0", [0], 1);
        assertStructure("9", [9], 1);
        assertStructure("85", [5, 8], 1);
        assertStructure("101", [1, 0, 1], 1);
      });
      
      test("size 2", () {
        assertStructure("0", [0], 2);
        assertStructure("9", [9], 2);
        assertStructure("86", [86], 2);
        assertStructure("102", [2, 1], 2);
        assertStructure("1020", [20, 10], 2);
        assertStructure("28050", [50, 80, 2], 2);
      });
      
      test("size 3", () {
        assertStructure("87", [87], 3);
        assertStructure("103", [103], 3);
      });
    });
    
    group("Integer operations", () { 
      test("getters", () {
        expect(i("-2").isNegative, isTrue);
        expect(i("-1").isMinusOne, isTrue);
        expect(i("0").isZero, isTrue);
        expect(i("1").isOne, isTrue);
      });
      
      test("negation", () {
        expect(~i("1"), equals(i("-1")));
        expect(~i("-1"), equals(i("1")));
      });
      
      test("absolute value", () {
        expect(i("-2").abs, equals(i("2")));
        expect(i("0").abs, equals(i("0")));
        expect(i("10").abs, equals(i("10")));
      });
      
      test("less than", () {
        expect(i("-2") < i("5"), isTrue);
        expect(i("2") < i("-5"), isFalse);
        expect(i("2") < i("5"), isTrue);
        expect(i("-2") < i("-5"), isFalse);
        expect(i("-5") < i("-2"), isTrue);
        expect(i("-5") < i("-5"), isFalse);
      });
      
      test("less than or equals", () {
        expect(i("-2") <= i("5"), isTrue);
        expect(i("2") <= i("-5"), isFalse);
        expect(i("2") <= i("5"), isTrue);
        expect(i("-2") <= i("-5"), isFalse);
        expect(i("-5") <= i("-2"), isTrue);
        expect(i("-5") <= i("-5"), isTrue);
      });
      
      test("greater than", () {
        expect(i("-2") > i("5"), isFalse);
        expect(i("2") > i("-5"), isTrue);
        expect(i("2") > i("5"), isFalse);
        expect(i("-2") > i("-5"), isTrue);
        expect(i("-5") > i("-2"), isFalse);
        expect(i("-5") > i("-5"), isFalse);
      });
      
      test("greater than or equals", () {
        expect(i("-2") >= i("5"), isFalse);
        expect(i("2") >= i("-5"), isTrue);
        expect(i("2") >= i("5"), isFalse);
        expect(i("-2") >= i("-5"), isTrue);
        expect(i("-5") >= i("-2"), isFalse);
        expect(i("-5") >= i("-5"), isTrue);
      });
      
      test("equals", () {
        expect(i("-5") == i("-5"), isTrue);
        expect(i("5") == i("6"), isFalse);
        expect(i("5") != i("6"), isTrue);
      });

      test("addition", () {
        expect(i("1") + i("1"), equals(i("2")));
        expect(i("0") + i("1"), equals(i("1")));
        expect(i("1000") + i("3"), equals(i("1003")));
        expect(i("501") + i("23"), equals(i("524")));
        expect(i("-3") + i("-3"), equals(i("-6")));
        expect(i("2") + i("-1"), equals(i("1")));
        expect(i("-2") + i("1"), equals(i("-1")));
        expect(i("250000") + i("1000000"), equals(i("1250000")));
      });
      
      test("increment", () {
        expect(i("1").increment, equals(i("2")));
        expect(i("-1").increment, equals(i("0")));
      });

      test("subtraction", () {
        expect(i("23") - i("501"), equals(i("-478")));
        expect(i("3") - i("5"), equals(i("-2")));
        expect(i("5") - i("3"), equals(i("2")));
        expect(i("-5") - i("3"), equals(i("-8")));
        expect(i("-15") - i("0"), equals(i("-15")));
        expect(i("501") - i("23"), equals(i("478")));
        expect(i("1") - i("-1"), equals(i("2")));
      });
      
      test("decrement", () {
        expect(i("1").decrement, equals(i("0")));
        expect(i("-1").decrement, equals(i("-2")));
      });
      
      test("multiplication", () {
        expect(i("11") * i("11"), equals(i("121")));
        expect(i("99") * i("99"), equals(i("9801")));
        expect(i("99") * i("224"), equals(i("22176")));
        expect(i("0") * i("1"), equals(i("0")));
        expect(i("1") * i("1"), equals(i("1")));
        expect(i("2") * i("1"), equals(i("2")));
        expect(i("3") * i("6"), equals(i("18")));
        expect(i("-3") * i("6"), equals(i("-18")));
        expect(i("-3") * i("-6"), equals(i("18")));
        expect(i("4") * i("10"), equals(i("40")));
        expect(i("50") * i("250"), equals(i("12500")));
        expect(i("-720") * i("2"), equals(i("-1440")));
        expect(i("720") * i("-2"), equals(i("-1440")));
        expect(i("720") * i("2"), equals(i("1440")));
        expect(i("-720") * i("-2"), equals(i("1440")));
      });
      
      test("pow", () {
        var big = Integer.ten.pow(Integer.ten);
        expect(big, equals(i("10000000000")));
      });
      
      //test("division", () {
        //expect(i("12500") ~/ i("250"), equals(i("50")));
      //});
    }); 
  }
  
  Integer i(String str) => new Integer(str);
}
