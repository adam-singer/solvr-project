// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full 
// or in part without the express written consent of Solvr is prohibited.

/*
class _MatrixVectorWidget extends _InputWidget {
  Element _matrixControls, _inputTable;
  
  _MatrixVectorWidget(): super(LinearAlgebraKeys.area, "widget-input-linear-algebra") {
    _matrixControls = new Element.html(""" 
        <article>
          <ul class='horizontal-list'> 
            <li>
              <input name='row-slider' type='range' min='1' max='10'/>
            </li>
            <li>
              <input name='column-slider' type='range' min='1' max='10'/>
            </li>
          </ul>
          <table></table>
        </article>
    """);
    content.nodes.add(_matrixControls);
    
    int rows = 2;
    int columns  = 2;
    
    queryAs(_matrixControls, "input[name='row-slider']", (InputElement rowSlider) {
      rowSlider.on.change.add((Event e) {
        rows = Math.parseInt(rowSlider.value);
        drawTable(rows, columns);
      }, true);
    });
    
    queryAs(_matrixControls, "input[name='column-slider']", (InputElement columnSlider) {
      columnSlider.on.change.add((Event e) {
        columns = Math.parseInt(columnSlider.value);
        drawTable(rows, columns);
      }, true);
    });
    
    _inputTable = _matrixControls.query("table");
  }
  
  drawTable(int rows, int columns) {
    print("draw rows $rows columns $columns");
    // determin type
    //Expect.isFalse(rows == 1 && columns == 1, "TODO show some informative message");
    String typeName = "unknown";
    
    if(rows > 1 && columns > 1) {
      typeName = "${rows}-by-${columns} Matrix";
    } else if(rows == 1) {
      typeName = "Column vector";
    } else if(columns == 1) {
      typeName = "Row vector";
    } 
    
    // build table
    Element tableHeader = new Element.html("<thead><tr><th colspan='${columns}'>${typeName}</th></tr></thead>");
    Element tableBody = new Element.html("<tbody></tbody>");
    for(int i=0; i<rows; i++) {
      Element row = new Element.html("<tr></tr>");
      for(int j=0; j<columns; j++) {
        Element cell = new Element.html("<td><input type='text'></input></td>");
        row.nodes.add(cell);
      }
      tableBody.nodes.add(row);
    }
    
    // attach table
    _inputTable.nodes.clear();
    _inputTable.nodes.add(tableHeader);
    _inputTable.nodes.add(tableBody);
  }
}
*/
