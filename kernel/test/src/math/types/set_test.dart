// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_test;

class SetTest {
  SetTest() {
    group('set test -', () {
      test('correct structure', () {
        assertExpression('{}', '{}');
        assertExpression('{x+x}', '{2 * x}');
        // TODO is the reordering really needed ?
        assertExpression('{x*x,2+2}', '{4,x^2}');
        assertExpression('{1,2,3,3,2,1}', '{1,2,3}');
      });
      
      test('errors', () {
        // TODO move these and come up with correct set tests
        //assertFailure('( x:2 )');
        //assertFailure('x:2');
        //assertFailure('2 == {2}');
      });
    });
    
    group('set test - operators', () {
      // TODO algebraic collection methods
      test('algebraic', () {
        
      });
      
      test('equivalence', () {
        assertExpression('{2} == {1,2,3}', 'false');
        assertExpression('{2} != {1,2,3}', 'true');
        assertExpression('{1,2} != {1,2}', 'false');
        assertExpression('{1,2} == {1,2}', 'true');
        assertExpression('{1,2} != {2,1}', 'false');
        assertExpression('{2,2,1,1} == {1,2}', 'true');
      });
      
      test('subset', () {
        assertExpression('{2} subset {1,2,3}', 'true');
        assertExpression('{2} !subset {1,2,3}', 'false');
        assertExpression('{2} !subset {1,{2},3}', 'true');
        assertExpression('{{2}} subset {{1},{2},{3}}', 'true');
      });
   
      test('union', () {
        assertExpression('{1,2,3} union {2,3,4}', '{1,2,3,4}');
        assertExpression('{2,3,4} union {1}', '{1,2,3,4}');
        assertExpression('{{2}} union {}', '{{2}}');
        assertExpression('{{2}} union {{1}}', '{{1},{2}}');
        assertExpression('{} union {}', '{}');
      });
      
      test('intersect', () {
        assertExpression('{1,3,2} intersect {4,2,3}', '{2,3}');
        assertExpression('{2,3,4} intersect {1}', '{}');
      });
      
      test('complement', () {
        assertExpression(r'{1,2,3} \ {2,3,4}', '{1}');
        assertExpression(r'{2,3,4} \ {1,2,3}', '{4}');
      });
      
      // TODO empty set
      
      // TODO use object operators to test interface structure (i.e. {1,2,3} is Algebraic)
    });
    
    group('set test - functions', () {
      test('intersectionOf', () {
        // TODO insersectionOf(s1, s2, ... s_n)
        expect(false, isTrue);
      });
      
      test('unionOf', () {
        // TODO unionOf(s1,s2, .... s_n)
        expect(false, isTrue);
      });
    });
 
    // TODO this is really interface methods
    group('set test - interface method', () {
      test('add', () {
        assertExpression('{}.add(1)', '{1}'); 
        assertExpression('{1}.add(2)', '{1,2}'); 
      });
      
      test('get', () {
        assertExpression('{1,2}.get(1)', '1'); 
        assertExpression('{1,2}.get(2)', '2'); 
      });
      
      test('length', () {
        assertExpression('{}.length()', '0'); 
        assertExpression('{1}.length()', '1'); 
        assertExpression('{1,2}.length()', '2'); 
      });
      
      test('remove', () {
        assertExpression('{1}.remove(1)', '{}'); 
        assertExpression('{1,2}.remove(2)', '{1}'); 
      });
    });
    
    group('set test - class method', () {
    });
  }
}
