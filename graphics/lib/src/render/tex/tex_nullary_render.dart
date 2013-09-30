// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_tex;

class _TexNullaryRender extends _AbstractTexRender implements NullaryRender {
  _TexNullaryRender(StringBuffer buf, ExprRender render): super(buf, render);
  
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
