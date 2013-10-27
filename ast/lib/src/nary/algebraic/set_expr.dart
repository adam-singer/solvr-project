// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

// TODO expose subset, union, ... as methods via some annotation

/** Represents a set fx. {x, y, z} */
class SetExpr extends _MapBasedCollection {
  factory SetExpr(List<Expr> operands) {
    var keyMapper = (Expr e) => e.toString();
    return new SetExpr._internal(operands, keyMapper);
  }

  SetExpr._internal(List<Expr> operands, _KeyMapper keyMapper): super(operands, keyMapper, ObjectTypes.SET);

  /** true if [other] is a subset of this */
  bool subset(SetExpr other) {
    bool res = true;
    other.forEach((Expr elm) {
      if(!contains(elm)) {
        res = false;
        return;
      }
    });
    return res;
  }

  SetExpr union(SetExpr other) {
    List<Expr> all = operands;
    all.addAll(other.operands);
    return asSet(all);
  }

  /** Get the intersection of this set with [other] */
  SetExpr intersect(SetExpr other) {
    List<Expr> same = [];
    forEach((Expr elm) {
      if(other.contains(elm)) {
        same.add(elm);
      }
    });
    return asSet(same);
  }

  /** Get the complement of this set with [other] */
  SetExpr complement(SetExpr other) {
    List<Expr> inThisOnly = [];
    forEach((Expr elm) {
      if(!other.contains(elm)) {
        inThisOnly.add(elm);
      }
    });
    return asSet(inThisOnly);
  }

  @override
  Expr get clone => asSet(_cloneExprList(operands));
  
  @override
  visit(ExprVisitor visitor) => visitor.visitSetExpr(this);
}

SetExpr asSet(List<Expr> elements) => new SetExpr(elements);
