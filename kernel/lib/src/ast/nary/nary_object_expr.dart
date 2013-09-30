// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Expression that represents a collection */
abstract class CollectionExpr extends ObjectExpr {
  CollectionExpr(IType type): super(type);

  operator [](int index) => operands[index];

  bool contains(Expr expr) => operands.any((Expr elm) => elm == expr);

  bool every(bool f(Expr element)) => operands.every(f);

  forEach(void f(Expr element)) => operands.forEach(f);

  List mapThis(dynamic f(Expr element)) => operands.map(f);

  Expr mapThisI(dynamic f(Expr element, int index)) {
    var clone = this.clone;
    var i = 0;
    var result = clone.map((Expr operand) {
      var morphed = f(operand, i);
      i++;
      return morphed;
    });
    return result;
  }

  int get length => operands.length;

  bool hasSameDimension(var other) => other.length == length;
}

/** Collection expression backed by a list */
abstract class _ListBasedCollection<T> extends CollectionExpr {
  _ListBasedCollection(this.operands, IType type): super(type) {
    operands.forEach((Expr elm) => elm.parent = this);
  }

  Expr map(ExprConverter converter) {
    _mapElements(converter, operands, this);
    return this;
  }

  List asList(dynamic converter(Expr element)) => operands.map(converter);
  
  List<T> operands;
}

/** N-ary object expression backed by a map */
abstract class _MapBasedCollection extends CollectionExpr {
  _MapBasedCollection(List<Expr> operands, this.keyMapper, IType type): super(type) {
    entries = _buildMap(operands);
  }

  asString(StringBuffer buf) => _renderElements(r"{", r",", r"}", buf, operands);

  Expr map(ExprConverter converter) {
    var values = operands;
    _mapElements(converter, values, this);
    entries = _buildMap(values);
    return this;
  }

  Map<String,Expr> _buildMap(List<Expr> elms) {
    var dict = new LinkedHashMap<String, Expr>();
    elms.forEach((Expr expr) {
      var key = keyMapper(expr);
      dict[key] = expr;
      expr.parent = this;
    });
    return dict;
  }

  List<Expr> get operands => new List.from(entries.values);
  
  final _KeyMapper keyMapper;
  Map<String, Expr> entries;
}

typedef String _KeyMapper(Expr expr);
