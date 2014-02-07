// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_kernel_math_checker;

class AlgebraicChecker extends Checker {
  AlgebraicChecker(this.typeChecker, this.registry);

  check(var expr) {
    expr.operands.forEach((Expr operand) {
      // TODO infer operand (i.e. handle functions)
      if(!isAlgebraic(operand)) {
        error("algebraic operator ${expr.token} cannot be applied to operand ${operand}");
      }
    });
    if(isBinary(expr)) {
      _checkBinary(expr);
    }
  }

  _checkBinary(var expr) {
    if(isDot(expr)) {
      _checkDot(expr);
    } else if(isProduct(expr)) {
      _checkProduct(expr);
    } else if(expr.operands.every(isAlgebraicCollection)) {
      _checkAlgebraicCollection(expr);
    }
  }

  _checkDot(DotExpr expr) {
    if(!expr.operands.every((Expr operand) => operand.anyOf([isVector, isMatrix]))) {
      if(isInvoke(expr.left) && isInvoke(expr.right)) {
        // case: fn().gn() here fn() and gn() must resolve to a vector/matrix
        checkFunctions(expr.token, [expr.left, expr.right], [isVector, isMatrix]);
      } else if(isInvoke(expr.left) && !isInvoke(expr.right)) {
        // case: fn().y here fn() and y must resolve to a vector/matrix
        // TODO search for functions inside y that could lead to the expression rsulting in a vector
      } else {
        // case: x.y here x and y must resolve to vector/matrix
        // TODO search for functions inside x/y that could lead to the expression rsulting in a vector
      }
    }
  }

  _checkProduct(ProductExpr expr) {
    // TODO infer operand (i.e. handle functions)
    if(expr.operands.every((Expr operand) => operand.anyOf([isVector, isMatrix]))) {
      error("cannot take the product of vectors or matrices, use dot or cross product instead");
    }
  }

  // TODO fix this, perhaps add generics to BinaryExpr (i.e. BinaryExpr<AlgebraicCollection, AlgebraicCollection>)
  _checkAlgebraicCollection(BinaryExpr expr) {
    var u1 = expr.left;
    var u2 = expr.right;
    // equal collection types can only be combined if they have the same cardinality
    if(u1.type == u2.type && u1.length != u2.length) {
      error("cannot apply ${expr.token} to unequal length $u1 and $u2");
    }
  }
  
  final TypeChecker typeChecker;
  final Registry registry;
}
