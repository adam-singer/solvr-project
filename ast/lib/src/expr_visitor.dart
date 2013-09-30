// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_ast;

/** Base class for visitors that knows how to visit every known expression type */
abstract class ExprVisitor implements 
  BinaryExprVisitor, 
  NaryExprVisitor, 
  NullaryExprVisitor, 
  SpecialExprVisitor, 
  UnaryExprVisitor { 
  
}

