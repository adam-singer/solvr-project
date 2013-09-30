// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

part of solvr_graphics_test;

// idea for plotting feature site http://mbostock.github.com/d3/
class ListPlotTest {
  Element container;
  ListPlotTest() {
    container = document.query("#container");
    
    plotYNegativeTest();
    //plotYTest();
    //plotXYTest();
    //plotXYColorTest();
  }
  
  // TODO move comments from here into documentation
  
  void plotYNegativeTest() {
    ListPlot plot = new ListPlot([-30, -20, -10, 0, 10, 20, 30]);
    plot.appendTo(container);
  }
  
  /**
   * plots points corresponding to a list of values, assumed to correspond to x coordinates 1, 2, ....
   */
  void plotYTest() {
    // TODO ensure that axis are scaled
    ListPlot plot = new ListPlot([0, 10, 20, 30, 40, 50, 60, 70, 80, 90]);
    plot.appendTo(container);
  }
  
  /**
   * plots a list of points with specified x and y coordinates.
   */
  void plotXYTest() {
    ListPlot plot = new ListPlot([[0,0], [10,10], [20,20], [30,30], [40,40], [50,50], [60,60], [70,70], [80,80], [90,90]]);
    plot.appendTo(container);
  }
  
  void plotXYColorTest() {
    ListPlot plot = new ListPlot([[0,0], [10,10], [20,20], [30,30], [40,40], [50,50], [60,60], [70,70], [80,80], [90,90]], { 
        "PlotStyle": { 
          "axisColor": "red"
        }
    });
    plot.appendTo(container);
  }
}
