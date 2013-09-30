// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_matchers;

/// Special expression matchers
bool isAnonymousFunction(var expr) => expr is AnonymousFunctionExpr;

bool isAssign(var expr) => expr is AssignExpr;

bool isBlock(var expr) => expr is BlockExpr;

bool isConditional(var expr) => expr is ConditionalExpr;

bool isFunction(var expr) => expr is FunctionExpr;

bool isGeneric(var expr) => expr is GenericExpr;

bool isInvoke(var expr) => expr is InvokeExpr;

bool isMethod(var expr) => expr is MethodExpr;

bool isNothing(Expr expr) => expr is NothingExpr;

bool isObject(var expr) => expr is ObjectExpr;

bool isReturn(var expr) => expr is ReturnExpr;

bool isSeq(var expr) => expr is SeqExpr;

bool isTyped(var expr) => expr is TypedExpr;