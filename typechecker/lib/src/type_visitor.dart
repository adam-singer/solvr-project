// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_type_checker;

/** Visitor that visits nodes and check their types are correct */
class TypeVisitor extends Object with 
  BinaryExprTypeVisitor,
  NaryExprTypeVisitor, 
  NullaryExprTypeVisitor, 
  SpecialExprTypeVisitor,
  UnaryExprTypeVisitor implements ExprVisitor {
  
  ExprVisitor get visitor => this;
}










