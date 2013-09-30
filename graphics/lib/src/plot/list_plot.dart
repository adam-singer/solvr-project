// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics;

// TODO add AspectRatio support http://reference.wolfram.com/mathematica/ref/AspectRatio.html
// TODO GoldenRatio as in Mathematica (http://reference.wolfram.com/mathematica/ref/GoldenRatio.html)
class ListPlot {
  final Logger _logger;
  List<Point2D> _points;
  DrawingCanvas _canvas;

  /**
   * Dispatching constructor
   */
  factory ListPlot(Dynamic data, [Dynamic options = null]) {
    // TODO merge options like in JQuery
    // TODO docu here (can be names, rgb, rgba or hex)
    if(options == null) {
      options = {
         "axisColor": "#474747",
         "pointColor": "#3a6c98"
      };
    }
    
    if(data.length == 0) {
      return;        
    }
    
    if(data[0] is num) {
      data = mapI(data, (num e, int i) => [i, e]);
      return new ListPlot._plot(data, options);
    } else if(data[0] is List<num>) {
      return new ListPlot._plot(data, options);
    } else if(data is Map) {
      return new ListPlot._plotAll(data, options);
    } else {
      throw new ExpectException("unknown data type for ${data}");
    }
  }
  
  ListPlot._plot(List<List<num>> data, Map options): _logger = LoggerFactory.getLogger("graphics.ListPlot") {
    var plot = new _PlotConfig.fromList(data, options["pointColor"]);
    // TODO _canvas = new DrawingCanvas(plot.minX, plot.maxX, plot.minY, plot.maxY);
    _canvas = new DrawingCanvas();
    _canvas.drawCoordinateSystem(options["axisColor"]);
    _canvas.drawPoints(plot.points);
  }
  
  /**
   * plots several lists of points
   */
  ListPlot._plotAll(Map<String, List<List<num>>> data, Map options): _logger = LoggerFactory.getLogger("graphics.ListPlot") {
    var allPlots = []; 
    num minX = 0, maxX = 0, minY = 0, maxY = 0; 
    data.forEach((String plotName, List<List<num>> plotData) {
      Map plotOptions = options[plotName];
      _PlotConfig plot = new _PlotConfig.fromList(plotData, plotOptions["pointColor"]);
      minX = smallest(plot.minX, minX);
      minY = smallest(plot.minY, minY);
      maxX = largest(plot.maxX, maxX);
      maxY = largest(plot.maxY, maxY);
      
      allPlots.add(plot);
    });
    
    // TODO _canvas = new DrawingCanvas(minX, maxX, minY, maxY);
    _canvas = new DrawingCanvas();
    allPlots.forEach((_PlotConfig plot) => _canvas.drawPoints(plot.points));
  }
  
  void appendTo(Element parent) => _canvas.appendTo(parent);
}

class _PlotConfig {
  final List<Point2D> points;
  num minX = 0, maxX = 0, minY = 0, maxY = 0; 

  factory _PlotConfig.fromList(List<List<num>> data, String color) {
    var coordinates = [];
    for(int i=0; i<data.length; i++) {
      var coordinate = data[i];
      coordinates.add(new Point2D.color(coordinate[0], coordinate[1], color));
    }
    return new _PlotConfig(coordinates);
  }
  
  _PlotConfig(this.points) {
    minX = _compare((res, cur) => smallest(cur.x, res));
    minY = _compare((res, cur) => smallest(cur.y, res));
    maxX = _compare((res, cur) => largest(cur.x, res));
    maxY = _compare((res, cur) => largest(cur.y, res));
  }
  
  _compare(comparator) => foldLeft(points, 0, comparator);
}

