// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_matchers;

/// Nullary expression matchers
bool isBool(var expr) => (expr is BoolExpr);

bool isNullary(Expr expr) => expr is NullaryExpr;

bool isNumber(var expr) => expr is NumberExpr;

bool isInteger(var expr) => (isNumber(expr) && expr.denominator.isOne);

bool isString(var expr) => expr is StringExpr;

bool isSymbol(var expr) => expr is SymbolExpr;



