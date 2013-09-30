// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited

part of solvr_graphics_test;

class TexRenderTest {
  TexRenderTest() 
    : _render = new TexRender()
  {
    entry = 1;
    
    // nullary
    renderExpr("x");
    renderExpr("pi");
    renderExpr("true");
    renderExpr("42");
    renderExpr("2.764");
    renderExpr("x_2");
    // unary
    renderExpr("-x");
    renderExpr("y!");
    renderExpr("1!");
    // binary
    renderExpr("x*y");
    renderExpr("x*x");
    renderExpr("x^1/2");
    renderExpr("true && false");
    renderExpr("{2} !subset {1,2,3}");
    // mixed
    renderExpr("2x + 3y!");
    renderExpr("x*y/y", false);
    // n-ary
    //renderExpr("1..10");
    renderExpr("[1,2]", false);
    renderExpr("[[1 2]; [3 4]]", false);
    renderExpr("{}");
    renderExpr("a * (1 + x)^2");
    renderExpr("[1 2]", false);
    // x in 0..5 | x^2
    //renderExpr("[[1/x x*y]; [y/x y]]", false);
  }
  
  renderExpr(String expression, [bool simplify = true]) {
    var kernel = new Kernel();
    Expr inputExpr = kernel.parse(expression);
    Expr simplifiedExpr = null;
    
    if(simplify) {
      simplifiedExpr = kernel.simplify(inputExpr);
    }
    
    if(simplify && inputExpr != simplifiedExpr) {
      document.body.query("#container").nodes.add(new Element.html("""
        <p>
          entry $entry: <span id='input-$entry'></span> = <span id='output-$entry'></span>
        </p>
      """));
      _render.renderAndAttach(inputExpr, "input-${entry}");
      _render.renderAndAttach(simplifiedExpr, "output-${entry}");
    } else {
      document.body.query("#container").nodes.add(new Element.html("""
        <p>
          entry $entry: <span id='input-$entry'></span>
        </p>
      """));
      _render.renderAndAttach(inputExpr, "input-${entry}");
    }
    
    entry++;
  }
  
  final Render _render;
  int entry;
}
