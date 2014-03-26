// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

/** Type analyzer for the Solvr language */
library solvr_analyzer;

import 'package:solvr_ast/solvr_ast.dart';

import 'src/analyzer_internals.dart';

/// TODO implement a Analyzer interface
class SolvrAnalyzer {
  // TODO environment
  analyze(Expr expr) {
    expr.visit(_analyzer);
  }
  
  final Analyzer _analyzer = new Analyzer();
}


