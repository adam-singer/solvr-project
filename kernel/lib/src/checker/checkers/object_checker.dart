// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_kernel_math_checker;

class ObjectChecker extends Checker {
  ObjectChecker(this.typeChecker, this.registry);

  check(var expr) {
    throw "TODO implement object checker";
  }
  
  final TypeChecker typeChecker;
  final Registry registry;
}
