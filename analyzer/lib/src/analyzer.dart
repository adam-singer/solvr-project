// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_analyzer_internal;

// TODO rename to checker once the old checker is gone

/** Visitor that visits nodes and check their types are correct */
class Analyzer extends Object with 
  BinaryExprAnalyzer,
  NaryExprAnalyzer, 
  NullaryExprAnalyzer, 
  SpecialExprAnalyzer,
  UnaryExprAnalyzer implements ExprVisitor {
  
  ExprVisitor get visitor => this;
}