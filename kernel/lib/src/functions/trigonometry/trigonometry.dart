// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_functions_trigonometry;

// TODO http://en.wikipedia.org/wiki/CORDIC
// TODO http://www.physicsforums.com/showthread.php?t=64958

// sinc = sin(x)/x http://en.wikipedia.org/wiki/Sinc_function

bool isSin(var expr) {
  if(expr.isInvoke()) {
    if(expr.name == "sin" && expr.operands.length == 1) {
      return true;
    }
  }
  return false;
}

Expr sin(var expr) => asInvoke("sin", expr);

Expr cos(var expr) => asInvoke("cos", expr);
