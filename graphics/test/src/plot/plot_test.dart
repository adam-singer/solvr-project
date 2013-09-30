// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

part of solvr_graphics_test;

class PlotTest {
  PlotTest() {
    Plot plot = new Plot();

    // plot a line
    //plot.functionPlot(-100, 101, (x) => 2);
    // plot a first degree polynomia
    //plot.functionPlot(-50, 51, (x) => 1.2*x + 1);
    // plot a second degree polynomia
    //plot.functionPlot(-100, 101, (x) => x * x);
    // plot a third degree polynomia
    //plot.functionPlot(-25, 26, (x) => (x * x * x) - 2);
    // TODO plot something advanced
    
    plot.appendTo(document.body.query("#container"));
  }
  

}
