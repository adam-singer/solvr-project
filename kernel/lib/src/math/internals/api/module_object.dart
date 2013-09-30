// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

// TODO get rid of the module concept entirely when dart offers reflection access to meta data
// @function('name')
// Expr function(...) ---

/** A module of functions and methods */
abstract class ModuleObject {
  List<FunctionObject> get functions;

  List<MethodObject> get methods;
}

/** Base class extended by concrete modules */
abstract class AbstractModule implements ModuleObject {
  AbstractModule()
    : functions = new List<FunctionObject>(),
      methods = new List<MethodObject>();

  registerFunction(FunctionObject function) {
    functions.add(function);
    function.module = this;
  }

  registerMethod(MethodObject method) {
    methods.add(method);
    method.module = this;
  }
  
  String toString() => this.runtimeType.toString();
  
  final List<FunctionObject> functions;
  final List<MethodObject> methods;
}
