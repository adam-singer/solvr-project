// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

part of solvr_graphics;

class DrawingCanvas {
  DrawingCanvas() {
    _canvas = new GElement();
    _canvas.attributes = {
      "stroke-width": "1",
      "stroke": "none",
      "transform": "translate(5,${height - 5}) scale(1,-1)"
    };
  }
  
  void drawCoordinateSystem([String axisColor = "rgba(71,71,71,1)"]) {
    // TODO scale if (maxX > width) || (minX/minY < 0) || (maxY > height)
    // TODO handle negative coordinates and don't use max/min as width, instead scale points within 
    final int step = 5;
    var coordinateSystem = new GElement();
    coordinateSystem.attributes["stroke"] = axisColor;
    
    // x axis
    var xAxis = new LineElement();
    xAxis.attributes = {
      "x1": 0,
      "y1": 0,
      "x2": width,
      "y2": 0                   
    };
    coordinateSystem.nodes.add(xAxis);
    for(int i=0; i<(width/step); i++) {
      var xAxisMark = new LineElement();
      xAxisMark.attributes = {
        "x1": i*step,
        "y1": 0,
        "x2": i*step,
        "y2": (i%step == 0 ? -4 : -2)
      };
      coordinateSystem.nodes.add(xAxisMark);
    }
    
    // y axis
    var yAxis = new LineElement();
    yAxis.attributes = {
      "x1": 0,
      "y1": 0,
      "x2": 0,
      "y2": height                 
    };
    coordinateSystem.nodes.add(yAxis);
    for(int i=0; i<(height/step); i++) {
      var yAxisMark = new LineElement();
      yAxisMark.attributes = {
        "x1": 0,
        "y1": i*step,
        "x2": (i%step == 0 ? -4 : -2),
        "y2": i*step
      };
      coordinateSystem.nodes.add(yAxisMark);
    }
    _canvas.nodes.add(coordinateSystem);
  }
  
  void drawPoints(List<Point2D> points) {
    points.forEach((Point2D point) => drawPoint(point));
  }
  
  // blue 3a6c98
  // green 6da463
  // yellow d4ad5a
  void drawPoint(Point2D point) {
    var svgPoint = new CircleElement();
    svgPoint.attributes = {
      "cx": point.x,
      "cy": point.y,
      "r": "1",
      "fill": point.rgbaColor,
      "stroke": point.rgbaColor
    };

    _canvas.nodes.add(svgPoint);
  }
  
  void appendTo(Element parent) {
    var svg = new SvgSvgElement();
    svg.attributes = {
      "height": height,
      "width": width,
      "version": "1.2"
    };
    svg.nodes.add(_canvas);
    parent.nodes.add(svg);
  }
  
  GElement _canvas; 
  final int height = 102;
  final int width = 168;
}

