// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_matcher;

/// Unary expression helpers
bool isFactorial(var expr) => expr is FactorialExpr;

bool isNegation(var expr) => expr is NegationExpr;

bool isNegative(var expr) => expr is NegativeExpr;

bool isUnary(Expr expr) => expr is UnaryExpr;


