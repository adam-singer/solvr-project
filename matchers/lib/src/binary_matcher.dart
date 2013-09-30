// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_matchers;

bool isBinary(Expr expr) => expr is BinaryExpr;

/// Algebraic expression matchers
bool isComplexNumber(var expr) => (expr is ComplexNumberExpr);

bool isDifference(var expr) => (expr is DifferenceExpr);

bool isDot(var expr) => (expr is DotExpr);

bool isFraction(Expr expr) => expr is FractionExpr;

bool isPower(var expr) => expr is PowerExpr;

/// Logical expression matchers
bool isAnd(var expr) => (expr is AndExpr);

bool isOr(var expr) => (expr is OrExpr);

/// Object expression matchers
bool isBind(var expr) => expr is BindExpr;

bool isGuard(var expr) => expr is GuardExpr;

bool isInstanceOf(var expr) => expr is InstanceOfExpr;

bool isNotInstanceOf(var expr) => expr is NotInstanceOfExpr;

bool isSubstitution(var expr) => expr is SubstitutionExpr;

/// Relational expressions matchers
bool isEqual(var expr) => expr is EqualExpr;

bool isGreaterThan(var expr) => expr is GreaterThanExpr;

bool isGreaterThanOrEqual(var expr) => expr is GreaterThanOrEqualExpr;

bool isLessThan(var expr) => expr is LessThanExpr;

bool isLessThanOrEqual(var expr) => expr is LessThanOrEqualExpr;

bool isNotEqual(var expr) => expr is NotEqualExpr;

bool isRelational(var expr) => expr is RelationalExpr;

/// Set expressions matchers
bool isComplement(var expr) => expr is ComplementExpr;

bool isEntry(var expr) => expr is EntryExpr;

bool isIntersect(var expr) => expr is IntersectExpr;

bool isNotSubset(var expr) => expr is NotSubsetExpr;

bool isSubset(var expr) => expr is SubsetExpr;

bool isUnion(var expr) => expr is UnionExpr;

