// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_ast;

/** Represents a matrix fx. {{1,2,3}, {4,5,6}} */
class MatrixExpr extends _ListBasedCollection<VectorExpr> {
  MatrixExpr(List<VectorExpr> operands): super(operands, ObjectTypes.MATRIX);

  asString(StringBuffer buf) {
    buf.write(r"[");
    mapI(operands, (Expr row, int i) {
      row.asString(buf);
      if(i < operands.length - 1) buf.write(r";");
    });
    buf.write(r"]");
  }

  Expr map(ExprConverter converter) {
    _mapElements(converter, operands, this);
    return this;
  }

  Expr mapThisI(f(Expr element, int index)) {
    var aClone = this.clone;
    int i = 0;
    var result = aClone.map((Expr operand) {
      var morphed = f(operand, i);
      i++;
      return morphed;
    });
    return result;
  }

  /// index matrix at (row, column)
  operator [](var idx) {
    var rowNr = idx[0];
    var columnNr = idx[1];
    if(rowNr > rows || columnNr > columns) {
      throw new RangeError('matrix indix $idx exceeds rows $rows and $columns');
    }

    var row = operands[rowNr];
    return row[columnNr];
  }

  List<int> get size => [rows, columns];

  bool hasSameDimension(MatrixExpr other) => hasSameElements(other.size, size);

  int get rows => operands.length;

  int get columns => operands[0].length;

  Expr get clone => matrixOf(_cloneExprList(operands, () => new List<VectorExpr>()));
}

MatrixExpr matrixOf(List<VectorExpr> elements) => new MatrixExpr(elements);
