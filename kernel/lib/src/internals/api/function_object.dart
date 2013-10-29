// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

/** A function */
abstract class FunctionObject extends InvokableObject {
  Expr invoke(TupleExpr args);

  AreaType get area;
}

/** Base class extended by concrete functions */
abstract class AbstractFunction extends AbstractInvokable implements FunctionObject {
  AbstractFunction(FunctionType functionType)
    : _functionType = functionType,
      super(functionType);

  Expr apply(TupleExpr args);

  Expr invoke(TupleExpr args) {
    if(!matchesArguments(args)) {
      throw new ArgumentError("expected argument types ${expectedArgumentTypes} got $args");
    }
    Expr result = apply(args);
    if(!matchesReturnType(result.type)) {
      throw new ArgumentError("expected result type ${expectedReturnType} got ${result.type}");
    }
    return result;
  }

  AreaType get area => _functionType.area;

  Logger get logger => LoggerFactory.getLoggerFor(this.runtimeType);

  String toString() => _functionType.toString();

  final FunctionType _functionType;
}
