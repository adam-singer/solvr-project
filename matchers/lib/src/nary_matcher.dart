// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_matchers;

/// Algebraic nary expressions matchers
bool isList(var expr) => expr is ListExpr;

bool isMatrix(var expr) => expr is MatrixExpr;

bool isProduct(var expr) => expr is ProductExpr;

bool isSet(var expr) => expr is SetExpr;

bool isSum(var expr) => expr is SumExpr;

bool isTuple(var expr) => expr is TupleExpr;

bool isVector(var expr) => expr is VectorExpr;

/// Other nary expression matchers
bool isCollection(var expr) => expr is CollectionExpr;

bool isDictionary(var expr) => expr is DictionaryExpr;

bool isInterval(var expr) => expr is IntervalExpr;

bool isNaryOperator(var expr) => expr is NaryOperatorExpr;