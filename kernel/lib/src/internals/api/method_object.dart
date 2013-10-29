// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

// TODO figure out if this can be removed when reflection supports meta data

/** A method object */
abstract class MethodObject<T extends ObjectExpr> extends InvokableObject {
  Expr invokeOn(T target, TupleExpr args);

  SuperTypeable get targetType;
}

/** Base class extended by concrete methods */
abstract class AbstractMethod<T extends ObjectExpr> extends AbstractInvokable implements MethodObject<T> {
  AbstractMethod(MethodType methodType)
    : _methodType = methodType,
      super(methodType);

  Expr applyOn(T target, TupleExpr args);

  Expr invokeOn(T target, TupleExpr args) {
    if(!matchesArguments(args)) {
      throw new ArgumentError("expected argument types ${expectedArgumentTypes} got $args");
    }
    Expr result = applyOn(target, args);
    if(!matchesReturnType(result.type)) {
      throw new ArgumentError("expected result type ${expectedReturnType} got ${result.type}");
    }
    return result;
  }

  SuperTypeable get targetType => _methodType.target;

  Logger get logger => LoggerFactory.getLogger("registry.${this.toString()}");

  String toString() => _methodType.toString();

  final MethodType _methodType;
}

