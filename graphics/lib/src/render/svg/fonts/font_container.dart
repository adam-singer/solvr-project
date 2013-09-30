// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_svg;

class FontContainer {
  FontContainer(this.fontname): glyphs = new Map<int, List>();
  
  final Map<int, List> glyphs;
  final String fontname;
}
