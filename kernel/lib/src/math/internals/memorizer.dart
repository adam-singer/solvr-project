// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_internals;

class Memorizer {
  factory Memorizer() {
    if(_instance == null) {
      _instance = new Memorizer._internal();
    }
    return _instance;
  }

  Memorizer._internal();

  final cache = new Map<String,Object>();
  static Memorizer _instance;
}

Memorizer get memorizer => new Memorizer();
