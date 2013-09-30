// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_matcher;

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