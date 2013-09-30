// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

part of solvr_graphics_render_svg;

class FontManager {
  static FontManager _instance;
  
  factory FontManager() {
    if(_instance == null) {
      _instance = new FontManager._internal();
    }
    return _instance;
  }
  
  FontManager._internal() {
    // add invisible header to document used to hold the glyphs
    var header = new Element.html("""<div id='svg-header' style='visibility: hidden: position: absolute; top: 0; left: 0; height: 1px;'></div>""");
    var svg = new SvgElement.tag("svg");
    _glyphs = new SvgElement.svg("<defs id='solvr-glyphs'></defs>");
    header.nodes.add(svg);
    svg.nodes.add(_glyphs);
    document.body.nodes.add(header);  
    // register fonts
    _registerFonts();
  }
  
  _registerFonts() {
    _registerFont(new MainRegular());
    _registerFont(new MathItalic());
  }
  
  _registerFont(FontContainer container) {
    container.glyphs.forEach((int charCode, List fontData) {
      var glyphId = "${container.fontname}-${charCode}";
      if(_fonts.containsKey(glyphId)) {
        throw new ArgumentError("duplicated glyph $glyphId");
      }
      _fonts[glyphId] = fontData;
    });
  }
  
  attachGlyph(String glyphId, Element container) {
    // lazy load glyphs as they are needed
    if(!_loaded.contains(glyphId)) {
      _loadGlyph(glyphId);
    }
    // TODO x/y coordinates
    var glyph = new SvgElement.svg("<use href='#${glyphId}'></use>");
    container.nodes.add(glyph);
  }
  
  String getGlyphIdForChar(int charCode) {
    // use "math itallic" for A-Z and a-z 
    if((charCode >= 0x41 && charCode <= 0x5A) || (charCode >= 0x61 && charCode <= 0x7A)) {
      return "math_italic-${charCode}";
    }
    throw "TODO dispatch char code $charCode";
  }
  
  _loadGlyph(String glyphId) {
    if(!_fonts.containsKey(glyphId)) {
      throw new ArgumentError("glyph ${glyphId} is not loaded");
    }
    var glyphData = _fonts[glyphId];
    var glyphPath = glyphData[4];
    var glyph = new SvgElement.svg("""<path id="${glyphId}" stroke-width='10' d='M${glyphPath}'></path>"""); 
    _glyphs.nodes.add(glyph);
    _loaded.add(glyphId);
  }
  
  final _loaded = new Set<String>();
  final _fonts = new Map<String, List>();
  Element _glyphs;
}
