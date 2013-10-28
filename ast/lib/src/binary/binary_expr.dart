// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Expression with two operands */
abstract class BinaryExpr extends Expr {
  BinaryExpr(Expr leftExpr, Expr rightExpr, IType typeInfo)
    : token = typeInfo.simpleName,
      type = typeInfo
  {
    left = leftExpr;
    right = rightExpr;
  }

  Expr get left => _left;

  set left(Expr left) {
    _left = left;
    _left.parent = this;
  }

  Expr get right => _right;

  set right(Expr right) {
    _right = right;
    _right.parent = this;
  }

  @override
  Expr map(ExprConverter converter) {
    left = converter(left);
    right = converter(right);
    return this;
  }

  @override
  List<Expr> get operands => [ left, right ];

  @override
  final IType type;
  
  final String token;
  Expr _left, _right;
}


