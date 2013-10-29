// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_functions_calculus;

Expr integrate(Expr expr, SymbolExpr symbol) {
  var res = _integralTable(expr, symbol);
  if(res == null) {
    res = _linearProperties(expr, symbol);
  }
  if(res == null) {
    res = _substitutionMethod(expr, symbol);
  }
  if(res == null) {
    var expanded = expand(expr);
    if(expanded != expr) {
      res = integrate(expanded, symbol);
    }
  }
  if(res == null) {
    // give up (for now)
    res = expr;
  }
  return expr;
}

Expr _integralTable(Expr expr, SymbolExpr symbol) {
  throw "TODO readd";
}

Expr _linearProperties(Expr expr, SymbolExpr symbol) {
  throw "TODO readd";
}

Expr _substitutionMethod(Expr expr, SymbolExpr symbol) {
  // TODO implement p 206
  throw "TODO readd";
}
