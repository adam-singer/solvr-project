// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_graphics_render_svg;

abstract class _AbstractSvgRender {
  _AbstractSvgRender(this._element, this._fontManager, this._exprRender);
  
  addText(List<int> charCodes) {
    charCodes.forEach((int charCode) {
      // TODO look into MathJAX
      String glyphId = _fontManager.getGlyphIdForChar(charCode);
    });
    //return unicode;
  }
  
  renderExpr(Expr expr) => _exprRender.render(expr);
  
  final SvgElement _element;
  final FontManager _fontManager;
  final ExprRender _exprRender;
}

