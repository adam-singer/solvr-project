// Copyright (c) 2013, the Solvr project authors. Please see the AUTHORS 
// file for details. All rights reserved. Use of this source code is 
// governed by a Apache license that can be found in the LICENSE file.

library solvr_graphics_render_svg;

import 'dart:svg';
import 'dart:html';

import 'render_api_lib.dart';

part 'svg/fonts/glyphs/main_regular.dart';
part 'svg/fonts/glyphs/math_italic.dart';
part 'svg/fonts/font_manager.dart';
part 'svg/fonts/font_container.dart';
part 'svg/abstract_svg_render.dart';
part 'svg/svg_binary_render.dart';
part 'svg/svg_nary_render.dart';
part 'svg/svg_nullary_render.dart';
part 'svg/svg_special_render.dart';
part 'svg/svg_unary_render.dart';

/**
 * [ExprRender] that renders expressions as SVG 
 * 
 * Links
 * - svg and text: http://www.svgbasics.com/simple_text.html
 * - unicode and math: http://unicode.org/reports/tr25/tr25-5.html
 * - unicode chars: http://en.wikipedia.org/wiki/List_of_Unicode_characters
 */
class SvgRender implements ExprRender<Element,Element> {
  SvgRender() {
    var canvas = new SvgElement.svg("<g stroke='black' fill='black' stroke-thickness='0' transform='matrix(1 0 0 -1 0 0)'>");
    
    // MathHI = https://github.com/mathjax/MathJax/blob/master/unpacked/jax/output/SVG/fonts/TeX/Math/Italic/Main.js
    // <path id="MJMATHI-74" stroke-width="10" d="M"></path>
    _element = new SvgElement.tag("svg");
    _element.nodes.add(canvas);
    _element.attributes = {
      "height": 50,
      "width": 800,
      "version": "1.2"
    };
    var fontManager;
    
    var binaryRender = new _SvgBinaryRender(canvas, fontManager);
    var naryRender = new _SvgNaryRender(canvas, fontManager);
    var nullaryRender = new _SvgNullaryRender(canvas, fontManager);
    var specialRender = new _SvgSpecialRender(canvas, fontManager);
    var unaryRender = new _SvgUnaryRender(canvas, fontManager);
  }
  
  @override
  Element render(Expr expr) {
    _init();
    _mathRender.render(expr);
    return _element;
  }
  
  @override
  renderAndAttach(Expr expr, Element target) {
    render(expr);
    attachTo(target);
  }
}
  
 
