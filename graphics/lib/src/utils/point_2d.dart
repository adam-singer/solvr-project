// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

part of solvr_graphics;

class Point2D {
  Point2D(num xCord, num yCord): this.color(xCord, yCord, new RGBAColor(51,102,204).toString());
  
  Point2D.color(this.x, this.y, this.rgbaColor);
  
  final String rgbaColor;
  final num x, y;
}

