// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_graphics_tex_render;

class NullaryExprTexRender implements NullaryExprVisitor {
  renderBool(BoolExpr expr) {
    add("${expr.value}");
  }
  
  renderNumber(NumberExpr expr) {
    add(expr.value);  
  }
  
  renderSymbol(SymbolExpr expr) {
    add(_getRepresentation(expr));  
  }
  
  String _getRepresentation(NullaryExpr expr) {
    var value = expr.value;
    if(value is String) {
      if(_greekLowerLetters.containsKey(value)) {
        return _greekLowerLetters[value];
      }
      if(_greekUpperLetters.containsKey(value)) {
        return _greekUpperLetters[value];
      }
    } else {
      value = "${value}";
    }
    return value;
  }
  
  static final _greekLowerLetters = const {
    "alpha": r"\alpha",
    "beta": r"\beta",
    "gamma": r"\gamma",
    "delta": r"\delta",
    "epsilon": r"\epsilon",
    "zeta": r"\zeta",
    "eta": r"\eta",
    "theta": r"\theta",
    "iota": r"\iota",
    "kappa": r"\kappa",
    "lambda": r"\lambda",
    "mu": r"\mu",
    "nu": r"\nu",
    "xi": r"\xi",
    "omikron": r"\omikron",
    "pi": r"\pi",
    "rho": r"\rho",
    "sigma": r"\sigma",
    "tau": r"\tau",
    "upsilon": r"\upsilon",
    "phi": r"\phi",
    "chi": r"\chi",
    "psi": r"\psi",
    "omega": r"\omega"
  };
  
  static final _greekUpperLetters = const {
    "Alpha": r"\Alpha",
    "Beta": r"\Beta",
    "Gamma": r"\Gamma",
    "Delta": r"\Delta",
    "Epsilon": r"\Epsilon",
    "Zeta": r"\Zeta",
    "Eta": r"\Eta",
    "Theta": r"\Theta",
    "Iota": r"\Iota",
    "Kappa": r"\Kappa",
    "Lambda": r"\Lambda",
    "Mu": r"\Mu",
    "Nu": r"\Nu",
    "Xi": r"\Xi",
    "Omikron": r"\Omikron",
    "Pi": r"\Pi",
    "Rho": r"\Rho",
    "Sigma": r"\Sigma",
    "Tau": r"\Tau",
    "Upsilon": r"\Upsilon",
    "Phi": r"\Phi",
    "Chi": r"\Chi",
    "Psi": r"\Psi",
    "Omega": r"\Omega"
  };
}
