// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_matchers;

/// Special expression matchers
bool isAnonymousFunction(var expr) => expr is AnonymousFunctionExpr;

bool isAssign(var expr) => expr is AssignExpr;

bool isBlock(var expr) => expr is BlockExpr;

bool isConditional(var expr) => expr is ConditionalExpr;

bool isFunction(var expr) => expr is FunctionExpr;

bool isInvoke(var expr) => expr is InvokeExpr;

bool isMethod(var expr) => expr is MethodExpr;

bool isNothing(Expr expr) => expr is NothingExpr;

bool isObject(var expr) => expr is ObjectExpr;

bool isReturn(var expr) => expr is ReturnExpr;

bool isSeq(var expr) => expr is SeqExpr;

bool isTyped(var expr) => expr is TypedExpr;