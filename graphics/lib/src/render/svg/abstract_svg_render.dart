// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_svg;

abstract class _AbstractSvgRender {
  _AbstractSvgRender(this._element, this._fontManager);
  
  addText(List<int> charCodes) {
    charCodes.forEach((int charCode) {
      // TODO look into MathJAX
      String glyphId = _fontManager.getGlyphIdForChar(charCode);
    });
    //return unicode;
  }
  
  final SvgElement _element;
  final FontManager _fontManager;
  final ExprRender render;
}

