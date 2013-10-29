// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_kernel_math_test;

import 'package:solvr_common/solvr_common.dart';
export 'package:solvr_common/solvr_common.dart';
import 'package:unittest/unittest.dart';

import 'package:solvr_kernel/solvr_kernel.dart';

part 'src/math/operators/arithmetic_operator_test.dart';
part 'src/math/operators/logic_operator_test.dart';
part 'src/math/operators/object_operator_test.dart';
part 'src/math/operators/relational_operator_test.dart';

part 'src/math/types/dictionary_test.dart';
part 'src/math/types/interval_test.dart';
part 'src/math/types/list_test.dart';
part 'src/math/types/matrix_test.dart';
part 'src/math/types/seq_test.dart';
part 'src/math/types/set_test.dart';
part 'src/math/types/tuple_test.dart';
part 'src/math/types/vector_test.dart';

part 'src/math/modules/algebra_module_test.dart';
part 'src/math/modules/builtin_module_test.dart';
part 'src/math/modules/calculus_module_test.dart';
part 'src/math/modules/number_theory_module_test.dart';
part 'src/math/modules/trigonometry_module_test.dart';

part 'src/math/simplifier_test.dart';
part 'src/math/solver_test.dart';

main() {
  //_testAll();
  _testSingle();
}

_testAll() {
  LoggerFactory.config['.*'].debugEnabled = false;
  
  // simplify
  new AutomaticSimplifierTest();
  
  // operators
  new ArithmeticOperatorTest();
  new LogicOperatorTest();
  new ObjectOperatorTest();
  new RelationalOperatorTest();
  
  // types
  new DictionaryTest();
  new IntervalTest();
  new ListTest();
  new MatrixTest();
  new SeqTest();
  new SetTest();
  new TupleTest();
  new VectorTest();
  
  // modules
  new AlgebraModuleTest();
  new BuiltinModuleTest();
  new CalculusModuleTest();
  new NumberTheoryModuleTest();
}

_testSingle() {
  LoggerFactory.config['.*'].debugEnabled = false;
  LoggerFactory.config['solvr_kernel.*'].debugEnabled = true;
  LoggerFactory.config['solvr_function.*'].debugEnabled = true;
  LoggerFactory.config['solvr_registry.*'].debugEnabled = true;
  
  // types
  //new DictionaryTest();
  //new IntervalTest();
  new ListTest();
  //new MatrixTest();
  //new SeqTest();
  //new SetTest();
  //new TupleTest();
  //new VectorTest();
  
  // simplify
  new AutomaticSimplifierTest();
  
  // operators
  new ArithmeticOperatorTest();
  new LogicOperatorTest();
  new ObjectOperatorTest();
  new RelationalOperatorTest();
}

assertExpression(String expression, var expectedValue) {
  var kernel = new Kernel();
  var value = kernel.evaluate(expression).toString();
  expect(value, equals(expectedValue));
}

assertFailure(String expression) {
  // TODO use exception matchers in unit test lib instead
  print('TODO test failure position reporting');
  var kernel = new Kernel();
  bool failed = false;
  var expr;
  try {
    expr = kernel.evaluate(expression);
  } on TypeError catch(e) {
    failed = true;
    print(e.toString());
  }
  expect(failed, isTrue, reason:'expression [$expression] contains errors but succeded in evaluating as [$expr]');
}

fail(String failureReason) {
  test(failureReason, () {
    expect(false, isTrue, reason:failureReason);
  });
}
