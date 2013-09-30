// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

part of solvr_graphics;

class RGBAColor {
  const RGBAColor(r, g, b): this.alpha(r, g, b, 1.0);
  
  const RGBAColor.alpha(this.r, this.g, this.b, this.a);
  
  String get colorString => "rgba(${r},${g},${b},${a})";
  
  final int r, g, b;
  final double a;
}

