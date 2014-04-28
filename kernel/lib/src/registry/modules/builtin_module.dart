// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_registry;

class BuiltinModule extends AbstractModule {
  BuiltinModule() {
    _registerMethods();
  }

  _registerMethods() {
    registerMethod(new _LengthMethod());
  }
}

// TODO add type matcher
class _LengthMethod extends AbstractMethod<CollectionExpr> {
  _LengthMethod(): super(CollectionsKeys.LENGTH);

  Expr applyOn(CollectionExpr collection, TupleExpr args) {
    return asNumber(collection.length);
  }
}

