// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

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
    return setOf(all);
  }

  /** Get the intersection of this set with [other] */
  SetExpr intersect(SetExpr other) {
    List<Expr> same = [];
    forEach((Expr elm) {
      if(other.contains(elm)) {
        same.add(elm);
      }
    });
    return setOf(same);
  }

  /** Get the complement of this set with [other] */
  SetExpr complement(SetExpr other) {
    List<Expr> inThisOnly = [];
    forEach((Expr elm) {
      if(!other.contains(elm)) {
        inThisOnly.add(elm);
      }
    });
    return setOf(inThisOnly);
  }

  Expr get clone => setOf(_cloneExprList(operands));
}

SetExpr setOf(List<Expr> elements) => new SetExpr(elements);
