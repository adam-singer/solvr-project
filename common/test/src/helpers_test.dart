// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_common_test;

class HelpersTest {
  HelpersTest() {
    group("Collection helpers -", () {
      test("foldRight", () {
        var concat = (String i, String j) => i + j;
        
        expect(foldRight([], "0", concat), equals("0"));
        expect(foldRight(["1"], "0", concat), equals("10"));
        expect(foldRight(["1","2"], "0", concat), equals("120"));
      });
      
      test("tail", () {
        expect(()=>tail([]), throwsRangeError);
        expect(tail([1]), isEmpty);
        expect(tail([1,2]), orderedEquals([2]));
      });
      
      test("headSet", () {
        expect(()=>headSet([]), throwsRangeError);
        expect(headSet([1]), isEmpty);
        expect(headSet([1,2]), orderedEquals([1]));
        expect(headSet([1,2,3]), orderedEquals([1,2]));
      });
      
      test("addFirst", () {
        expect(addFirst([], 0), orderedEquals([0]));
        expect(addFirst([1], 0), orderedEquals([0,1]));
      });
      
      test("reverseList", () {
        expect(reverseList([]), isEmpty);
        expect(reverseList([1]), orderedEquals([1]));
        expect(reverseList([1,2]), orderedEquals([2,1]));
        expect(reverseList([1,2,3]), orderedEquals([3,2,1]));
      });
      
      test("firstWhere", () {
        var comp = (a) => a == 2;
        expect(firstWhere([1], comp), isNull);
        expect(firstWhere([1,2], comp), equals(2));
        expect(firstWhere([1,3,4], comp), isNull);
        expect(firstWhere([1,2,3,2,1], comp), equals(2));
      });
      
      test("hasSameElements", () {
        expect(hasSameElements([], []), isTrue);
        expect(hasSameElements([1], []), isFalse);
        expect(hasSameElements([1], [2,1]), isTrue);
        expect(hasSameElements([1,2], [2,1]), isTrue);
        expect(hasSameElements([1,2,3], [2,1]), isFalse);
        expect(hasSameElements([1,2,3], [2,1,3]), isTrue);
        expect(hasSameElements([1,2,3], [2,1,3,4]), isTrue);
      });
    });
    
    group("String helpers -", () {
      test("containsOnly", () {
        expect(containsOnly("1","1"), isTrue);
        expect(containsOnly("11","1"), isTrue);
        expect(containsOnly("111","11"), isFalse);
        expect(containsOnly("12","1"), isFalse);
        expect(containsOnly("12","12"), isTrue);
        expect(containsOnly("121","12"), isFalse);
        expect(containsOnly("1212","12"), isTrue);
        expect(containsOnly("12 12","12"), isFalse);
      });
      
      test("reverse", () {
        expect(reverse(""), equals(""));
        expect(reverse("1"), equals("1"));
        expect(reverse("12"), equals("21"));
        expect(reverse("1 2 3"), equals("3 2 1"));
      });
    });
  }
}

