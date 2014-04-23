// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_matchers;

/// Unary expression helpers
bool isFactorial(var expr) => expr is FactorialExpr;

bool isNegation(var expr) => expr is NegationExpr;

bool isNegative(var expr) => expr is NegativeExpr;

bool isUnary(Expr expr) => expr is UnaryExpr;


