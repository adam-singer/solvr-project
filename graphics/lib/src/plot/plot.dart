// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics;

// TODO get animation working http://demonstrations.wolfram.com/PlotAQuadraticPolynomial
class Plot {
  SVGElement _svg;
  
  Plot() {
    // TODO use drawing canvas
    _svg = new SVGElement.tag("svg");
    _svg.attributes = {
      "height:": 400,
      "width": 400
    };
  }

  void functionPlot(num from, num to, f) {
    final int unitsize = 10; // pixels pr 
    var d = "";
    var lastY = 0;
    var lastX = 0;
    for (num i=from; i<to; i+=1) {
      var x = i/unitsize;
      var y = f(x);
      d = d.concat(" ${d == '' ? 'M': 'L'}${(x*unitsize)},${(y*unitsize)}");
      
      lastY = y;
      lastX = x;
    }
    
    // TODO figure out what comma numbers in SVG means
    // TODO smoothen out by adjusting interpolation step based on how big chunks x and y moves in
    var path = new SVGElement.tag("path");
    path.attributes["d"] = d;
    
    var g = new SVGElement.tag("g");
    g.attributes = {
      "stroke-width": "2",
      "stroke": "black",
      "fill": "none",
      "transform": "translate(100,${200}) scale(1,-1)"
    };
    
    g.nodes.add(path);
    _svg.nodes.add(g);
  }
  
  void appendTo(Element parent) => parent.nodes.add(_svg);
}
