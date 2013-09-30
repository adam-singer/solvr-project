// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

part of solvr_graphics_test;

class SvgRenderTest {
  SvgRenderTest()
    : _render = new SvgRender()
  {
    _container = document.query("#container");
    entry = 1;
    
    // nullary 
    renderExpr("x");
    //renderExpr("pi");
    //renderExpr("true");
    //renderExpr("42");
    //renderExpr("2.764");
    //renderExpr("x_2");
    // unary
    //renderExpr("-x");
    //renderExpr("y!");
    //renderExpr("1!");
    // binary
    //renderExpr("x*y");
    //renderExpr("x*x");
    //renderExpr("x^1/2");
    //renderExpr("true && false");
    //renderExpr("{2} !subset {1,2,3}");
    // mixed
    //renderExpr("2x + 3y!");
    //renderExpr("x*y/y", false);
    // n-ary
    //renderExpr("1..10");
    //renderExpr("[1,2]", false);
    //renderExpr("[[1 2]; [3 4]]", false);
    //renderExpr("{}");
    //renderExpr("a * (1 + x)^2");
    //renderExpr("[1 2]", false);
    // x in 0..5 | x^2
    //renderExpr("[[1/x x*y]; [y/x y]]", false);
  }
  
  // TODO intercept copy/paste http://stackoverflow.com/questions/6035071/intercept-paste-event-in-javascript
  renderExpr(String expressionString, [bool simplify = true]) {
    var kernel = new Kernel();
    var expression = kernel.parse(expressionString);
    _render.renderAndAttach(expression, _container);
    
    entry++;
  }
  
  final Render _render;
  Element _container;
  int entry;
}
