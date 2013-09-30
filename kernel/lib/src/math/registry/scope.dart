// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_registry;

class Scope {
  registerSymbol(SymbolExpr variable, Expr value) => _userSymbols[variable.value] = value;

  bool isBound(SymbolExpr symb) => _boundSymbols.contains(symb.value);

  bindSymbols(List<SymbolExpr> symbols) {
    symbols.forEach((SymbolExpr symb) {
      var variable = symb.value;
      if(_boundSymbols.contains(variable)) {
        throw "binding error ${variable} already bound";
      }
      _boundSymbols.add(variable);
    });
  }

  bool isKnownSymbol(SymbolExpr symb) => _userSymbols.containsKey(symb.value);

  Expr getSymbolValue(symb) => _userSymbols[symb.value];
  
  final _userSymbols = new Map<String, Expr>();
  final _userFunctions = new Map<String, Expr>();
  final _boundSymbols = new Set<String>();
}
