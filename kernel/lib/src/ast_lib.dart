// Copyright (c) 2013 Solvr. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

/** Abstract syntax tree */
library solvr_kernel_ast;

import 'dart:math' as Math;
import 'dart:collection';

import 'package:solvr_common/solvr_common.dart';
import 'package:unittest/matcher.dart';

import 'types_lib.dart';

part 'ast/binary/algebraic/complex_number_expr.dart';
part 'ast/binary/algebraic/difference_expr.dart';
part 'ast/binary/algebraic/dot_expr.dart';
part 'ast/binary/algebraic/fraction_expr.dart';
part 'ast/binary/algebraic/power_expr.dart';

part 'ast/binary/logical/and_expr.dart';
part 'ast/binary/logical/or_expr.dart';

part 'ast/binary/object/bind_expr.dart';
part 'ast/binary/object/guard_expr.dart';
part 'ast/binary/object/instance_of_expr.dart';
part 'ast/binary/object/not_instance_of_expr.dart';
part 'ast/binary/object/substitution_expr.dart';

part 'ast/binary/relational/equal_expr.dart';
part 'ast/binary/relational/greater_than_expr.dart';
part 'ast/binary/relational/greater_than_or_equal_expr.dart';
part 'ast/binary/relational/less_than_expr.dart';
part 'ast/binary/relational/less_than_or_equal_expr.dart';
part 'ast/binary/relational/not_equal_expr.dart';

part 'ast/binary/set/complement_expr.dart';
part 'ast/binary/set/entry_expr.dart';
part 'ast/binary/set/intersect_expr.dart';
part 'ast/binary/set/not_subset_expr.dart';
part 'ast/binary/set/subset_expr.dart';
part 'ast/binary/set/union_expr.dart';

part 'ast/binary/binary_expr.dart';

part 'ast/nary/algebraic/operator/product_expr.dart';
part 'ast/nary/algebraic/operator/sum_expr.dart';

part 'ast/nary/algebraic/list_expr.dart';
part 'ast/nary/algebraic/matrix_expr.dart';
part 'ast/nary/algebraic/set_expr.dart';
part 'ast/nary/algebraic/tuple_expr.dart';
part 'ast/nary/algebraic/vector_expr.dart';

part 'ast/nary/dictionary_expr.dart';
part 'ast/nary/interval_expr.dart';
part 'ast/nary/nary_object_expr.dart';
part 'ast/nary/nary_operator_expr.dart';

part 'ast/nullary/bool_expr.dart';
part 'ast/nullary/nullary_expr.dart';
part 'ast/nullary/number_expr.dart';
part 'ast/nullary/string_expr.dart';
part 'ast/nullary/symbol_expr.dart';

part 'ast/special/anonymous_function_expr.dart';
part 'ast/special/assign_expr.dart';
part 'ast/special/block_expr.dart';
part 'ast/special/conditional_expr.dart';
part 'ast/special/function_expr.dart';
part 'ast/special/generic_expr.dart';
part 'ast/special/invoke_expr.dart';
part 'ast/special/method_expr.dart';
part 'ast/special/nothing_expr.dart';
part 'ast/special/object_expr.dart';
part 'ast/special/return_expr.dart';
part 'ast/special/typed_expr.dart';
part 'ast/special/seq_expr.dart';

part 'ast/unary/factorial_expr.dart';
part 'ast/unary/negative_expr.dart';
part 'ast/unary/negation_expr.dart';
part 'ast/unary/unary_expr.dart';

part 'ast/expr.dart';
part 'ast/position.dart';
part 'ast/expr_errors.dart';

/**
 * TODO describe
 */
_renderElements(String start, String delimiter, String end, StringBuffer buf, Iterable<Expr> elements) {
  buf.write(start);
  mapI(elements, (Expr elm, int i) {
    elm.asString(buf);
    if(i < elements.length - 1) buf.write(delimiter);
  });
  buf.write(end);
}

/**
 * TODO describe
 */
_mapElements(ExprConverter converter, List<Expr> elements, Expr parent) {
  mapI(elements, (Expr arg, int i) {
    elements[i] = converter(arg);
    elements[i].parent = parent;
  });
}

/**
 * TODO desribe
 */
List<Expr> _cloneExprList(List<Expr> list, [var builder = null]) {
  if(builder == null) {
    builder = () => new List<Expr>();
  }
  var clone = builder();
  list.forEach((Expr expr) => clone.add(expr.clone));
  return clone;
}

