// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

/** Abstract syntax tree */
library solvr_ast;

import 'dart:math' as Math;
import 'dart:collection';

import 'package:solvr_common/solvr_common.dart';
import 'package:solvr_types/solvr_types.dart';

part 'src/binary/algebraic/complex_number_expr.dart';
part 'src/binary/algebraic/difference_expr.dart';
part 'src/binary/algebraic/dot_expr.dart';
part 'src/binary/algebraic/fraction_expr.dart';
part 'src/binary/algebraic/power_expr.dart';

part 'src/binary/logical/and_expr.dart';
part 'src/binary/logical/or_expr.dart';

part 'src/binary/object/bind_expr.dart';
part 'src/binary/object/guard_expr.dart';
part 'src/binary/object/instance_of_expr.dart';
part 'src/binary/object/not_instance_of_expr.dart';
part 'src/binary/object/substitution_expr.dart';

part 'src/binary/relational/equal_expr.dart';
part 'src/binary/relational/greater_than_expr.dart';
part 'src/binary/relational/greater_than_or_equal_expr.dart';
part 'src/binary/relational/less_than_expr.dart';
part 'src/binary/relational/less_than_or_equal_expr.dart';
part 'src/binary/relational/not_equal_expr.dart';

part 'src/binary/set/complement_expr.dart';
part 'src/binary/set/entry_expr.dart';
part 'src/binary/set/intersect_expr.dart';
part 'src/binary/set/not_subset_expr.dart';
part 'src/binary/set/subset_expr.dart';
part 'src/binary/set/union_expr.dart';

part 'src/binary/binary_expr.dart';

part 'src/nary/algebraic/operator/product_expr.dart';
part 'src/nary/algebraic/operator/sum_expr.dart';

part 'src/nary/algebraic/list_expr.dart';
part 'src/nary/algebraic/matrix_expr.dart';
part 'src/nary/algebraic/set_expr.dart';
part 'src/nary/algebraic/tuple_expr.dart';
part 'src/nary/algebraic/vector_expr.dart';

part 'src/nary/dictionary_expr.dart';
part 'src/nary/interval_expr.dart';
part 'src/nary/nary_collection_expr.dart';
part 'src/nary/nary_operator_expr.dart';

part 'src/nullary/bool_expr.dart';
part 'src/nullary/nullary_expr.dart';
part 'src/nullary/number_expr.dart';
part 'src/nullary/string_expr.dart';
part 'src/nullary/symbol_expr.dart';

part 'src/special/anonymous_function_expr.dart';
part 'src/special/assign_expr.dart';
part 'src/special/block_expr.dart';
part 'src/special/conditional_expr.dart';
part 'src/special/function_expr.dart';
part 'src/special/generic_expr.dart';
part 'src/special/invoke_expr.dart';
part 'src/special/method_expr.dart';
part 'src/special/nothing_expr.dart';
part 'src/special/object_expr.dart';
part 'src/special/return_expr.dart';
part 'src/special/typed_expr.dart';
part 'src/special/seq_expr.dart';

part 'src/unary/factorial_expr.dart';
part 'src/unary/negative_expr.dart';
part 'src/unary/negation_expr.dart';
part 'src/unary/unary_expr.dart';

part 'src/visitor/binary_expr_visitor.dart';
part 'src/visitor/nary_expr_visitor.dart';
part 'src/visitor/nullary_expr_visitor.dart';
part 'src/visitor/special_expr_visitor.dart';
part 'src/visitor/unary_expr_visitor.dart';

part 'src/expr.dart';
part 'src/position.dart';
part 'src/expr_errors.dart';
part 'src/expr_visitor.dart';
part 'src/string_expr_visitor.dart';

/** Renders collection of [elements] inside [start] and [end] with elements delimited by [delimiter] */
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
 * Clone list of expr into a new list of deep clones. 
 * 
 * TODO do we ever use the builder function ?, if not remove the optional argument
 */
List<Expr> _cloneExprList(List<Expr> list, [var builder = null]) {
  if(builder == null) {
    builder = () => new List<Expr>();
  }
  var clone = builder();
  list.forEach((Expr expr) => clone.add(expr.clone));
  return clone;
}

