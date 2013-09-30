// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_matchers;

/// Nullary expression matchers
bool isBool(var expr) => (expr is BoolExpr);

bool isNullary(Expr expr) => expr is NullaryExpr;

bool isNumber(var expr) => expr is NumberExpr;

bool isInteger(var expr) => (isNumber(expr) && expr.denominator.isOne);

bool isString(var expr) => expr is StringExpr;

bool isSymbol(var expr) => expr is SymbolExpr;



