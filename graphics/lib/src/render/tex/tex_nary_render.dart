// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

part of solvr_graphics_render_tex;

class _TexNaryRender extends _AbstractTexRender implements NaryRender {
  _TexNaryRender(StringBuffer buf, ExprRender render): super(buf, render);
  
  renderInterval(IntervalExpr interval) {
    renderExpr(interval.start);
    renderExpr(interval.start);
    add("..");
    if(!isNothing(interval.step)) {
      renderExpr(interval.step);
      add("..");
    }
    renderExpr(interval.end);
  }
  
  renderList(ListExpr list) => renderOperands(r"\left[", r",", r"\right]", list.operands);
  
  renderMatrix(MatrixExpr matrix) {
    _renderMathMatrix(() {
      mapI(matrix.operands, (var row, int i) {
        if(isVector(row)) {
          mapI(row.operands, (Expr elm, int j) {
            renderExpr(elm);
            if(j < row.operands.length - 1) add(r"&");
          });
        } else {
          renderExpr(row);
        }
        if(i < matrix.operands.length - 1) add(r"\\");
      });    
    });
  }
  
  renderProduct(ProductExpr product) {
    if(product.operands[0].toString() == "-1") {
      // -1 * x * y * .. = -x * y * ...
      add(r"-");
      renderOperands("", r" \cdot ", "", tail(product.operands));
    } else {
      renderOperands("", r" \cdot ", "", product.operands);
    }
  }
  
  renderSet(SetExpr aSet) {
    if(aSet.operands.isEmpty) {
      add(r"\emptyset");
    } else {
      renderOperands(r"\left\{", r",", r"\right\}", aSet.operands);
    }
  }
  
  renderSum(SumExpr sum) => renderOperands("", r" + ", "", sum.operands);
  
  renderTuple(TupleExpr tuple) => renderOperands(r"\left(", r",", r"\right)", tuple.operands);
  
  renderVector(VectorExpr vector) {
    _renderMathMatrix(() {
      mapI(vector.operands, (Expr elm, int i) {
        renderExpr(elm);
        if(i < vector.operands.length - 1) add(r"\\");
      });
    });
  }
  
  _renderMathMatrix(bodyRender) {
    _buf.write(r"\left[");
    _buf.write(r"\begin{matrix} ");
    bodyRender();
    _buf.write(r" \end{matrix}");
    _buf.write(r"\right]");
  }
}
