// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_checker;

class LogicalChecker extends Checker {
  LogicalChecker(this.typeChecker, this.registry);

  check(var expr) {
    throw "TODO implement logic checker";
  }
  
  final TypeChecker typeChecker;
  final Registry registry;
}
