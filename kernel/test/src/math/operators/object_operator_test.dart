// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class ObjectOperatorTest {
  ObjectOperatorTest() {
    group('object operators test -', () {
      test('in', () {
        /*
          static const BIND = const OperatorType("In", OperatorTypes.OBJECT, "in");
         */
      });
      
      test('guard', () {
        /*
         static const GUARD = const OperatorType("Guard", OperatorTypes.OBJECT, "|");
         */
      });
      
      test('instance of', () {
        /*
          static const INSTANCE = const OperatorType("Instance of", OperatorTypes.OBJECT, "is");
        TODO inheritance 
         */
      });
      
      test('not instance of', () {
        /*
         static const NOT_INSTANCE = const OperatorType("Not instance of", OperatorTypes.OBJECT, "is!");
          TODO inheritance 
         */
      });
      
      test('substitution', () {
        /*
        static const SUBSTITUTION = const OperatorType("Substitution", OperatorTypes.OBJECT, ":=");
         */
      });
    });
  }
}
